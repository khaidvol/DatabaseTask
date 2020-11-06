--B-tree
drop index if exists students_name_idx;
drop index if exists students_surname_idx;
drop index if exists students_number_idx;

create index students_name_idx on public.students using btree (name);
create index students_surname_idx on public.students using btree (surname);
create index students_number_idx on public.students using btree (phone);


--Hash
drop index if exists students_name_hash;
drop index if exists students_surname_hash;
drop index if exists students_phone_hash;

create index students_name_hash on public.students USING hash(name);
create index students_surname_hash on public.students USING hash(surname);
create index students_phone_hash on public.students USING hash(phone);


--needed for gin & gist indexes
CREATE EXTENSION IF NOT EXISTS pg_trgm;


--GIN
drop index if exists students_name_gin;
drop index if exists students_surname_gin;
drop index if exists students_phone_gin;

create index students_name_gin on public.students USING gin(name gin_trgm_ops);
create index students_surname_gin on public.students USING gin(surname gin_trgm_ops);
create index students_phone_gin on public.students USING gin(phone gin_trgm_ops);


--GIST
drop index if exists students_name_gist;
drop index if exists students_surname_gist;
drop index if exists students_phone_gist;

create index students_name_gist on public.students USING gist(name gist_trgm_ops);
create index students_surname_gist on public.students USING gist(surname gist_trgm_ops);
create index students_phone_gist on public.students USING gist(phone gist_trgm_ops);