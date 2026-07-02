export type Project = {
  title: string;
  summary: string;
  impact: string;
  tools: string[];
  href: string;
};

export const projects: Project[] = [
  {
    title: 'Hello Stock',
    summary:
      'A Telegram market research assistant that routes financial questions through LangGraph agents for research, runtime analysis, and web search.',
    impact:
      'Ingests 20+ RSS feeds and financial APIs, stores market data in PostgreSQL, and uses pgvector-backed RAG for summaries and signal scoring.',
    tools: ['Python', 'LangGraph', 'OpenAI API', 'PostgreSQL', 'pgvector'],
    href: 'https://github.com/whr129/Hello-Stock',
  },
  {
    title: 'Go Wallet',
    summary:
      'A microservices-based wallet system in Go for concurrent transactions, withdrawals, notifications, and log ingestion.',
    impact:
      'Used Redis distributed locking with Lua scripts for idempotent transactions and load tests for 200+ concurrent wallet operations.',
    tools: ['Go', 'Gin', 'gRPC', 'Redis', 'PostgreSQL', 'RabbitMQ'],
    href: 'https://github.com/whr129/Go-Wallet',
  },
];
