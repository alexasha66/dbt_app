FROM python:3.10-slim-buster

RUN apt-get update \
    && apt-get install -y --no-install-recommends

# RUN apt-get install -y postgresql-client && chmod +x wait-for-postgres.sh

# WORKDIR /usr/src/dbt/dbt_project

WORKDIR /usr/src/dbt/dbt_project

# Install the dbt Postgres adapter. This step will also install dbt-core
RUN pip install --upgrade pip
RUN pip install dbt-core==1.5.2 dbt-postgres==1.5.2

# Install dbt dependencies (as specified in packages.yml file)
# Build seeds, models and snapshots (and run tests wherever applicable)
# RUN echo "alias dbt-set-profile='unset DBT_PROFILES_DIR && export DBT_PROFILES_DIR=\$PWD'" >> ~/.bashrc
CMD dbt deps && dbt build --profiles-dir profiles && sleep sinfinity
# CMD python -c 'while 1: import ctypes; ctypes.CDLL(None).pause()'

# CMD ["dbt", "--version"]
