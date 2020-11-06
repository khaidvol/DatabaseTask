import org.apache.ibatis.jdbc.ScriptRunner;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.sql.SQLException;

public class DatabaseConfigurator {

    private static final Logger logger = Logger.getLogger(DatabaseConfigurator.class);

    public static final String SCHEMA = "src/main/resources/db/ddl-tables.sql";
    public static final String STUDENTS = "src/main/resources/db/test-data-students.sql";
    public static final String SUBJECTS = "src/main/resources/db/test-data-subjects.sql";
    public static final String MARKS = "src/main/resources/db/test-data-results.sql";


    private DatabaseConfigurator() {
    }

    public static void autoConfiguration() {
        //create schema and change packet limits
        executeSqlScript(SCHEMA);
        executeSqlScript(STUDENTS);
        executeSqlScript(SUBJECTS);
        executeSqlScript(MARKS);

    }

    private static void executeSqlScript(String sqlScript) {
        try {
            ScriptRunner scriptRunner = new ScriptRunner(Datasource.getConnection());
            scriptRunner.runScript(new BufferedReader(new FileReader(sqlScript)));
        } catch (FileNotFoundException | SQLException e) {
            logger.error(e.getMessage(), e);
        }
    }
}
