FROM public.ecr.aws/docker/library/python:3.9-slim

WORKDIR /app

COPY . /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libc-dev libpq-dev

RUN pip install pipenv && pipenv install --deploy --ignore-pipfile

ENV FLASK_APP=src/app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=3000

EXPOSE 3000

CMD ["flask", "run"]

ENV NEW_RELIC_APP_NAME="blacklists"
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LICENSE_KEY=09f1bca8cf77665cee4759b14973a469FFFFNRAL
ENV NEW_RELIC_LOG_LEVEL=info

ENTRYPOINT [ "pipenv", "run", "newrelic-admin", "run-program" ]

