FROM python:3.10

WORKDIR /app

COPY backend/requirements.txt .
COPY frontend/package*.json .

RUN pip install -r requirements.txt
RUN npm install

COPY . .

CMD ["npm", "start"]