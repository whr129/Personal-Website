# Go Wallet

A high-performance microservices-based wallet system built in Golang, handling concurrent transaction requests with robust consistency guarantees.

## Tech Stack

Golang, Gin, Redis, PostgreSQL, RabbitMQ, Docker, GitHub Actions

## Features

- Built with Gin framework, using goroutines and worker pools for scalable performance under heavy load
- Combined PostgreSQL pessimistic locks and transactional idempotency with Redis distributed locks to coordinate concurrent balance updates
- Integrated RabbitMQ for async email notifications and log ingestion into MongoDB, improving system responsiveness
- CI/CD pipeline with GitHub Actions automating testing, builds, and deployments, reducing release cycles by 60%

[View on GitHub](https://github.com/whr129/Go-Wallet)
