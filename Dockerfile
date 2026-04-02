FROM python:3.14.3-trixie

WORKDIR /app

# copy the application
COPY backend/ .
COPY frontend/ .

# python dependencies, and update pip
RUN pip install -r requirements.txt --no-cache-dir
RUN pip install --upgrade pip

# nodejs
RUN apt-get update
RUN apt-get install -y npm
RUN npm install

# finalize, expose ports, start app
COPY . .

EXPOSE 3000
EXPOSE 8000
EXPOSE 27017

CMD ["sh", "-c", "cd frontend && npm start"]
