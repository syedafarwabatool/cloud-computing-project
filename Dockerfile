 FROM postgres:15
ENV POSTGRES_DB=cc_asgn
ENV POSTGRES_USER=....
ENV POSTGRES_PASSWORD=....
COPY ./init.sql /docker-entrypoint-initdb.d/
EXPOSE 5432
