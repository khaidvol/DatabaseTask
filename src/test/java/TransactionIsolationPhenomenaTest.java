import org.apache.log4j.Logger;
import org.junit.Test;

import java.sql.*;

public class TransactionIsolationPhenomenaTest {

    private static final Logger logger = Logger.getLogger(TransactionIsolationPhenomenaTest.class);

    public static final String ISOLATION_SQL = "SHOW default_transaction_isolation;";
    private static final String SELECT_SQL = "select * from students where id = 1;";
    private static final String ORIGINAL_DATA_SQL = "update students set name = 'Yer' where id = '1';";
    private static final String UPDATE_SQL = "update students set name = 'Jessica' where id = '1';";

    @Test
    public void phenomenaTest() {
        try (Connection connection1 = Datasource.getConnection();
             Connection connection2 = Datasource.getConnection();
             Statement statement1 = connection1.createStatement();
             Statement statement2 = connection2.createStatement();
        ) {
            //disable auto commit


            connection1.setAutoCommit(false);
            connection2.setAutoCommit(false);

            ResultSet rs1 = statement1.executeQuery(ISOLATION_SQL);
            if(rs1.next()){
                logger.info("Isolation level in connection 1: " + rs1.getString(1));
            }
            ResultSet rs2 = statement2.executeQuery(ISOLATION_SQL);
            if(rs2.next()){
                logger.info("Isolation level in connection 2: " + rs2.getString(1));
            }


            logger.info("Start transaction and read name and surname for student with id = 1 in connection 1:");
            rs1 = statement1.executeQuery(SELECT_SQL);
            if(rs1.next()){
                logger.info(rs1.getInt(1) + ", "+ rs1.getString(2) + ", "+ rs1.getString(3));
            }

            logger.info("Start transaction in connection 2 and update name for student with id = 1. (no commit yet)");
            statement2.execute(UPDATE_SQL);
            logger.info("Connection 2 data update - done.");


            logger.info("Re-read data in connection 1. Still the same:");
            rs1 = statement1.executeQuery(SELECT_SQL);
            if(rs1.next()){
                logger.info(rs1.getInt(1) + ", "+ rs1.getString(2) + ", "+ rs1.getString(3));
            }

            logger.info("Commit update name transaction in connection 2.");
            connection2.commit();
            logger.info("Connection 2 transaction commit - done.");

            logger.info("Re-read data in connection 1. Data changed:");
            rs1 = statement1.executeQuery(SELECT_SQL);
            if(rs1.next()){
                logger.info(rs1.getInt(1) + ", "+ rs1.getString(2) + ", "+ rs1.getString(3));
            }

            logger.info("Read Committed is the default isolation level in PostgreSQL. " +
                    "That's why 'nonrepeatable read' phenomena is possible. " +
                    "Transaction in connection1 re-reads data it has previously read and finds that data has been modified " +
                    "by another transaction in connection2 (that committed since the initial read).");

            //back data to starting position and close resources.
            statement1.execute(ORIGINAL_DATA_SQL);
            connection1.commit();
            rs1.close();
            rs2.close();

            connection1.setAutoCommit(true);
            connection2.setAutoCommit(true);

        } catch (SQLException e) {
            logger.error(e.getMessage(), e);
        }
    }

}
