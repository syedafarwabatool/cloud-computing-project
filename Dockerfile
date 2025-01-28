 FROM postgres:15
ENV POSTGRES_DB=cc_asgn
ENV POSTGRES_USER=farwa
ENV POSTGRES_PASSWORD=farwa
COPY ./init.sql /docker-entrypoint-initdb.d/
EXPOSE 5432
