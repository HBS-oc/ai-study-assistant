# AI Study Assistant

## Description
This application is a chatbot that aims to help students, the backend uses Google's Gemini API.

## Features
- Upload or paste notes
- AI summary
- AI quiz generation

## Tech Stack
- Backend: Python (Flask)
- AI: Gemini API
- Database: MongoDB Atlas
- Deployment: Render
- CI/CD: GitHub Actions

## Team Members
- Hamad Almansouri (60302091)
    Role: Backend & Database

- Abdulrahman Al-Mutawah (60102286)
    Role: AI & Testing

- Saeed Abdullah Dar (60307149)
    Role: Frontend & DevOps

## Timeline
Week 11: Setup + proposal  
Week 12: Core features + AI  
Week 13: Deployment + CI/CD  

## Table of Contents

1. [Project Overview](#project-overview)
2. [Screenshot](#screenshot)
3. [Architecture](#architecture)
4. [Setup & Installation](#setup--installation)
5. [Configuration & Environment](#configuration--environment)
6. [Usage Guide](#usage-guide)
7. [Deployment](#deployment)
8. [Original repository](#original-repository)

---

## Project Overview

**Tutor Agent** is an AI-powered educational assistant that leverages a multi-agent along with multi turn architecture to provide specialized tutoring in mathematics and physics (with extensibility for more domains). It uses Google's Gemini API for LLM-powered reasoning, and routes student queries to the most appropriate specialist agent, which can use tools like calculators and knowledge bases to generate comprehensive, step-by-step answers.

---

## Architecture

```
Frontend (React) <--> Backend API (Flask) <--> Gemini API & MongoDB
                          |                        |
                    Tutor Agent (Router)      Redis Cache
                    /      |        \         (Rate Limiting)
                   /       |         \
            Math Agent  Physics Agent  (More coming soon)
               |            |             |
           Tools Pool (Calculator, Knowledge Base, Physics Constants)
```

- **Frontend:** React SPA for chat, conversation management, and agent explanations.
- **Backend:** Flask API for routing, agent orchestration, and persistent conversation storage (MongoDB).
- **Redis:** Handles rate limiting, caching, and session management.
- **Agents:** Modular Python classes for each subject/domain.
- **Tools:** Pluggable utilities (calculator, knowledge base, constants).
- **LLM:** Google Gemini API for analysis, explanations, and tool orchestration.

## Setup & Installation

### Prerequisites

- Python 3.9+
- MongoDB (local or cloud)
- Redis Server
- Google Gemini API key

## Configuration & Environment

**.env.example** (rename to `.env` and fill in values):

```
# API Keys
GEMINI_API_KEY=your_gemini_api_key_here

# Backend Configuration
FLASK_APP=app.py
FLASK_ENV=development
FLASK_DEBUG=1
PORT=8000
FRONTEND_URL=http://localhost:3000
MONGODB_URI=
DATABASE_NAME=
REDIS_HOST=redis-13324.c262.us-east-1-1.ec2.redns.redis-cloud.com
REDIS_USERNAME=default
REDIS_PASSWORD=xxxxxxxxx
REDIS_PORT=13324
REDIS_DB=0

# Frontend Configuration
REACT_APP_API_URL=http://localhost:8000/api/v1
```

### Backend

```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
# Edit .env and add your GEMINI_API_KEY, MongoDB URI, etc.
python3 run.py
```

### Frontend

```bash
cd frontend
npm install
npm start
```

### Dockerfile

```
docker build . -t ai-study-assistant`
docker run -it -p 3000:3000 -p 8000:8000 ai-study-assistant
```

---

## Usage Guide

1. Open the frontend at [http://localhost:3000](http://localhost:3000).
2. Enter your academic question (e.g., "Solve 2x + 5 = 11" or "Explain Newton's laws").
3. The system will:
   - Analyze the question's subject
   - Route to the appropriate agent
   - Use tools as needed (calculator, knowledge base, constants)
   - Return a detailed, step-by-step answer
4. Manage conversations in the sidebar (view, switch, delete).

### API Endpoints


#### Health Check

- `GET /health`
  - Returns API health status
  - Response: `{"status": "healthy", "message": "API is running"}`
  - Status: 200 OK

#### Ask Question

- `POST /ask`
  - Submit a question to the Tutor Agent
  - Required body parameters:
    ```json
    {
      "question": "What is the derivative of x^2?",
      "user_id": "required-user-id"
    }
    ```
  - Optional body parameters:
    - `conversation_id`: If not provided, a new conversation will be created
  - Success Response (200 OK):
    ```json
    {
      "response": "The answer...",
      "agent": "agent_name",
      "subject": "identified_subject",
      "tools_used": ["tool1", "tool2"],
      "conversation_id": "conversation_id"
    }
    ```

#### Conversations

- `GET /conversations`

  - List user's conversations
  - Required query parameter: `user_id`
  - Success Response (200 OK):
    - Returns array of conversation metadata including title, last message, and timestamps

- `GET /conversations/<conversation_id>`

  - Get messages for a specific conversation
  - Required query parameter: `user_id`
  - Success Response (200 OK):
    ```json
    {
        "status": "success",
        "data": {
            "conversation_id": "id",
            "messages": [...],
            "title": "conversation_title",
            "created_at": "timestamp",
            "updated_at": "timestamp"
        }
    }
    ```

- `DELETE /conversations/<conversation_id>`
  - Delete a specific conversation
  - Required query parameter: `user_id`
  - Success Response (200 OK):
    ```json
    {
      "status": "success",
      "message": "Conversation deleted successfully"
    }
    ```

All endpoints may return a 500 Internal Server Error with an appropriate error message if an unexpected error occurs.

### Frontend

- Main chat UI: `src/components/ChatPage.js`
- Conversation management: `src/components/ConversationSidebar.js`
- Message rendering: `src/components/Message.js`
- API service: `src/services/api.js`

---

## Deployment

- **Backend:** Deployed Flask app (Render).
- **Frontend:** Deployed React app (Vercel).
- **Environment:** Set all secrets and environment variables in your deployment platform.

## Original repository
https://github.com/samrathreddy/Tutor-multi-ai-agent