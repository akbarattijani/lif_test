# API Design & Schema Structure

This document for the proposed API structure and Database Schema if this application need to be migrated to a backend service (e.g., Golang).

## 1. Database Schema (Relational/SQL)

PostgreSQL or MySQL database.

**Table: `users`**
| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | UUID | PRIMARY KEY | Unique user identifier |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | User login email |
| `password` | VARCHAR | NOT NULL | Hashed password (Bcrypt/Argon2) |
| `created_at` | TIMESTAMP | DEFAULT NOW() | |

**Table: `task`**
| Column | Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id` | SERIAL | PRIMARY KEY | Unique todo identifier |
| `uid` | UUID | FOREIGN KEY (users.id) | **User Isolation Key** |
| `title` | VARCHAR(255) | NOT NULL | Task title |
| `description` | TEXT | | Task details |
| `is_completed` | BOOLEAN | DEFAULT FALSE | Status of the task |
| `created_at` | TIMESTAMP | DEFAULT NOW() | |

---

## 2. API Endpoints (RESTful JSON)

### Authentication
**POST** `/api/v1/auth/login`

**Request:**
```json
{
  "email": "user@example.com",
  "password": "secretpassword"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR...", 
  "expired": 3600
}
```

### Get All Task
**GET** `/api/v1/tasks`
```text
Authorization: Bearer <token>
```

**Response:**
```json
{
  "data": [
    {
      "id": 1,
      "uid": "ajjjsk112",
      "title": "Buy groceries",
      "description": "Milk, Eggs, Bread",
      "is_completed": false,
      "created_at": "2023-10-27T10:00:00Z"
    }
  ]
}
```

### Create Task
**POST** `/api/v1/task`
```text
Authorization: Bearer <token>
```
**Request:**
```json
{
  "title": "Create PRD",
  "description": "Finish basic PRD"
}
```

**Response:**
```json
{
  "code": 200, 
  "message": "success"
}
```

### Update Task
**PUT** `/api/v1/task/:id`
```text
Authorization: Bearer <token>
```
**Request:**
```json
{
  "title": "Create PRD",
  "description": "Finish basic PRD"
}
```

**Response:**
```json
{
  "code": 200, 
  "message": "success"
}
```

### Update Task Status
**PATCH** `/api/v1/task/status/:id`
```text
Authorization: Bearer <token>
```
**Request:**
```json
{
  "is_completed": true
}
```

**Response:**
```json
{
  "code": 200, 
  "message": "success"
}
```

### Delete Task
**DELETE** `/api/v1/task/:id`
```text
Authorization: Bearer <token>
```

**Response:**
```json
{
  "code": 200, 
  "message": "success"
}
```

