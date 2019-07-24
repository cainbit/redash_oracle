FROM redash/redash:7.0.0.b18042

USER root

# Oracle instantclient
ADD oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip
ADD oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip
ADD oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip /tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

RUN apt-get update  -y
RUN apt-get install -y unzip

RUN unzip /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /usr/local/
RUN ln -s /usr/local/instantclient_12_2 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

RUN apt-get install libaio-dev -y
RUN apt-get clean -y

ENV ORACLE_HOME=/usr/local/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/instantclient

RUN pip install cx_Oracle==5.3
COPY oracle.py /app/redash/query_runner/oracle.py
COPY jql.py /app/redash/query_runner/jql.py
USER redash
#Add REDASH ENV to add Oracle Query Runner 
ENV REDASH_ADDITIONAL_QUERY_RUNNERS=redash.query_runner.oracle
