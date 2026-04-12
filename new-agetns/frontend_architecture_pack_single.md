
# Frontend Architecture Pack (React + Redux Toolkit)

## 1. INSTRUCTIONS
- Use functional components
- Feature-based architecture
- Centralized API layer
- Redux Toolkit only

## 2. ARCHITECTURE
Layers:
UI -> State -> Services -> Utils

Data Flow:
UI -> Dispatch -> Redux -> API -> Store -> UI

## 3. STATE MANAGEMENT
Principles:
- Minimal state
- Normalized data
- Use createSlice and createAsyncThunk
- Use selectors

Example:
{
  auth: {},
  users: {},
  products: {},
  ui: {}
}

## 4. COMPONENT GUIDELINES
Types:
- Presentational
- Container

Rules:
- Small reusable components
- One component per file

## 5. API LAYER
services/
- apiClient.js
- featureService.js

Rules:
- No API calls inside components
- Handle errors globally

## 6. AI / COPILOT AGENT RULES
- Follow project structure
- Use Redux Toolkit
- Avoid legacy Redux
- Generate modular code
