import {
  ArrowUpRight,
  BriefcaseBusiness,
  Github,
  Linkedin,
  Mail,
  MapPin,
  Send,
  Sparkles,
} from 'lucide-react';
import { projects } from './data/projects';

const skills = [
  'C/C++',
  'Python',
  'Go',
  'Java',
  'TypeScript',
  'React',
  'FastAPI',
  'Spring Boot',
  'LangGraph',
  'LangChain',
  'PostgreSQL',
  'Redis',
  'AWS',
  'Docker',
  'Kubernetes',
  'Terraform',
];

const experience = [
  {
    role: 'Software Engineer Intern',
    company: 'Rocket Innovation Studio',
    meta: 'May 2026 - Aug 2026 | Detroit, MI',
    bullets: [
      'Launched a FastAPI rule-configuration admin platform with PostgreSQL connection pooling and AWS S3 storage, reducing implementation turnaround time by 30%.',
      'Developed LangGraph email agents for routing, summarization, and agent assistance, cutting manual email triage time from 18 to 12 minutes per email.',
      'Designed a RabbitMQ-backed Celery worker to process 500+ documents per day and automated Kubernetes deployments with Terraform, Helm, and Azure DevOps CI/CD.',
    ],
  },
  {
    role: 'Data Science and Machine Learning Intern',
    company: 'Bayes Fintech Inc. (RockWallet)',
    meta: 'Jan 2025 - Aug 2025 | Toronto, ON',
    bullets: [
      'Engineered PySpark ETL pipelines on AWS Glue for operations analytics, reducing report generation time by 40%.',
      'Led development of a LangChain-powered Slack bot with MCP tools and AWS S3 integration, reducing operations lookup time by 90%.',
      'Built support-data classification workflows with AWS Bedrock, automated HubSpot analytics for 100K+ customers, and improved mid-year revenue forecasting with a Random Forest model.',
    ],
  },
  {
    role: 'Software Developer Intern',
    company: 'Keyrus (China) Ltd.',
    meta: 'May 2024 - Aug 2024 | Shanghai, China',
    bullets: [
      'Developed a microservices-based order management system for order processing and inventory tracking.',
      'Optimized Spring Boot REST APIs with MySQL, reducing p95 latency by 10% and lowering backend error rates.',
      'Improved frontend performance by 0.5 seconds through modular React components and local storage cache optimization.',
    ],
  },
];

function App() {
  return (
    <main>
      <nav className="site-nav" aria-label="Primary navigation">
        <a className="brand" href="#top" aria-label="Howard Wang home">
          HW
        </a>
        <div className="nav-links">
          <a href="#projects">Projects</a>
          <a href="#skills">Skills</a>
          <a href="#experience">Experience</a>
          <a href="#contact">Contact</a>
        </div>
      </nav>

      <section id="top" className="hero section">
        <div className="hero-copy">
          <p className="eyebrow">
            <Sparkles size={16} aria-hidden="true" />
            Waterloo CS student
          </p>
          <h1>
            Hi, I am <span className="nowrap">Howard Wang.</span>
          </h1>
          <p className="hero-text">
            I am a third-year University of Waterloo computer science student specializing in AI with a statistics minor. I enjoy building backend systems, AI agents, data pipelines, and practical web tools.
          </p>
          <div className="hero-actions">
            <a className="button primary" href="#projects">
              View work
              <ArrowUpRight size={18} aria-hidden="true" />
            </a>
            <a className="button secondary" href="mailto:howardwang0315@gmail.com">
              <Mail size={18} aria-hidden="true" />
              Email me
            </a>
          </div>
        </div>
        <aside className="hero-panel" aria-label="Professional snapshot">
          <div className="availability">Seeking software engineering internships</div>
          <dl>
            <div>
              <dt>Focus</dt>
              <dd>Backend, AI agents, data systems</dd>
            </div>
            <div>
              <dt>Based in</dt>
              <dd>
                <MapPin size={16} aria-hidden="true" />
                Toronto, Canada
              </dd>
            </div>
            <div>
              <dt>Education</dt>
              <dd>Third-year Waterloo CS, AI specialization</dd>
            </div>
          </dl>
        </aside>
      </section>

      <section className="section about" aria-labelledby="about-heading">
        <p className="section-kicker">About</p>
        <h2 id="about-heading">I like building systems that turn messy workflows into reliable software.</h2>
        <p>
          I have worked across software engineering, data science, and machine learning internships,
          with projects involving FastAPI, Spring Boot, React, LangGraph, AWS, Kubernetes, and
          production data pipelines. I care about shipping useful tools that are fast, testable, and
          easy for a team to operate.
        </p>
      </section>

      <section id="projects" className="section" aria-labelledby="projects-heading">
        <div className="section-heading">
          <div>
            <p className="section-kicker">Featured Projects</p>
            <h2 id="projects-heading">Selected work</h2>
          </div>
          <a className="text-link" href="https://github.com/whr129" target="_blank" rel="noreferrer">
            GitHub
            <ArrowUpRight size={16} aria-hidden="true" />
          </a>
        </div>
        <div className="project-grid">
          {projects.map((project) => (
            <article className="project-card" key={project.title}>
              <h3>{project.title}</h3>
              <p>{project.summary}</p>
              <p className="impact">{project.impact}</p>
              <ul aria-label={`${project.title} tools`}>
                {project.tools.map((tool) => (
                  <li key={tool}>{tool}</li>
                ))}
              </ul>
              <a href={project.href}>
                Learn more
                <ArrowUpRight size={16} aria-hidden="true" />
              </a>
            </article>
          ))}
        </div>
      </section>

      <section id="skills" className="section skills-section" aria-labelledby="skills-heading">
        <div>
          <p className="section-kicker">Skills and Tools</p>
          <h2 id="skills-heading">Languages, frameworks, and infrastructure I use.</h2>
        </div>
        <div className="skill-list">
          {skills.map((skill) => (
            <span key={skill}>{skill}</span>
          ))}
        </div>
      </section>

      <section id="experience" className="section" aria-labelledby="experience-heading">
        <p className="section-kicker">Experience</p>
        <h2 id="experience-heading">Internship experience across backend, AI, ML, and data work.</h2>
        <div className="timeline">
          {experience.map((item) => (
            <article key={`${item.company}-${item.role}`}>
              <BriefcaseBusiness size={20} aria-hidden="true" />
              <div>
                <div className="experience-header">
                  <div>
                    <h3>{item.role}</h3>
                    <p className="company">{item.company}</p>
                  </div>
                  <p className="meta">{item.meta}</p>
                </div>
                <ul>
                  {item.bullets.map((bullet) => (
                    <li key={bullet}>{bullet}</li>
                  ))}
                </ul>
              </div>
            </article>
          ))}
        </div>
      </section>

      <section id="contact" className="section contact" aria-labelledby="contact-heading">
        <div>
          <p className="section-kicker">Contact</p>
          <h2 id="contact-heading">I am open to software engineering and AI engineering opportunities.</h2>
          <p>
            The best way to reach me is by email. I am especially interested in backend systems,
            applied AI, data infrastructure, and product engineering roles.
          </p>
        </div>
        <div className="contact-actions">
          <a className="button primary" href="mailto:howardwang0315@gmail.com">
            <Send size={18} aria-hidden="true" />
            howardwang0315@gmail.com
          </a>
          <a className="button secondary" href="https://github.com/whr129" target="_blank" rel="noreferrer">
            <Github size={18} aria-hidden="true" />
            GitHub
          </a>
          <a className="button secondary" href="https://www.linkedin.com/in/howard-wang-a7b504280/" target="_blank" rel="noreferrer">
            <Linkedin size={18} aria-hidden="true" />
            LinkedIn
          </a>
        </div>
      </section>

      <footer>
        <p>© {new Date().getFullYear()} Howard Wang.</p>
        <a href="#top">Back to top</a>
      </footer>
    </main>
  );
}

export default App;
