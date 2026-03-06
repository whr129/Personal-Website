# GitIQ

A Git-aware agent that tracks code changes and auto-generates documentation for repositories using LLM and RAG techniques.

## Tech Stack

LLM, RAG, ChromaDB, Redis, MongoDB, FastAPI

## Features

- Custom code indexing and embedding pipeline with ChromaDB for precise semantic search and retrieval
- Multi-threaded concurrent processing achieving 3-5x faster indexing and scalable documentation generation
- Redis-based session memory for Q&A chat, reducing context-rebuild latency by 40%
- PostgreSQL with indexed tables for efficient queries and historical tracking of documentation versions

[View on GitHub](https://github.com/whr129/GitIQ)
