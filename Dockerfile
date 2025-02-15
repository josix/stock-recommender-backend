FROM python:3.8.2

ENV BASE_DIR /usr/local
ENV APP_DIR $BASE_DIR/app


# Adding backend directory to make absolute filepaths consistent across services
WORKDIR $APP_DIR

# Install Python dependencies
RUN pip install pipenv
COPY Pipfile* $APP_DIR
RUN pipenv lock --keep-outdated --requirements > requirements.txt
RUN pip3 install --upgrade pip -r $APP_DIR/requirements.txt
# Add the rest of the code
COPY . $APP_DIR

ENV PORT=$PORT
EXPOSE $PORT
 
# Be sure to use 0.0.0.0 for the host within the Docker container,
# otherwise the browser won't be able to find it
CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT