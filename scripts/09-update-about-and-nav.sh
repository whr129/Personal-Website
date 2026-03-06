#!/usr/bin/env bash
# Update the About page content and rebuild the navigation menu.
# Run as root on the VPS.
#
# Usage: sudo bash 09-update-about-and-nav.sh

set -euo pipefail

WP_DIR="/var/www/howardwang129.com"
cd "${WP_DIR}"

echo "=== Updating About Page and Navigation ==="

echo "[1/3] Updating About page content..."
ABOUT_ID=$(wp post list --post_type=page --title='About' --field=ID --allow-root)

if [ -z "${ABOUT_ID}" ]; then
    echo "About page not found, creating..."
    ABOUT_ID=$(wp post create --post_type=page --post_title='About' --post_status=publish --porcelain --allow-root)
fi

wp post update "${ABOUT_ID}" --post_content="$(cat <<'HTMLCONTENT'
<h2>Hey, I'm Howard</h2>

<p>I'm a Computer Science student at the <strong>University of Waterloo</strong>, specializing in <strong>Artificial Intelligence</strong> with a minor in <strong>Statistics</strong> (class of 2028). I'm passionate about building scalable backend systems, distributed computing, and applied machine learning.</p>

<h2>Work Experience</h2>

<h3>Bayes Fintech Inc. (RockWallet) — Toronto, ON</h3>
<p><em>Data Science and Machine Learning Intern | Jan 2025 – Aug 2025</em></p>
<ul>
  <li>Engineered high-performance ETL pipelines on AWS Glue using PySpark for operations and marketing analytics</li>
  <li>Built MCP map-reduce categorization tool using LangChain deployed on AWS EC2, cutting support lookup time by 90%</li>
  <li>Integrated tooling with Slack for real-time customer data retrieval, reducing query resolution time for support teams</li>
  <li>Developed Random Forest model enhancing revenue forecasting accuracy for data-driven decisions</li>
  <li>Automated real-time marketing analytics with ETL workflows syncing properties for 100K+ customers on HubSpot</li>
</ul>

<h3>Keyrus (China) Ltd. — Shanghai, China</h3>
<p><em>Software Developer Intern | May 2024 – Aug 2024</em></p>
<ul>
  <li>Developed microservices-based Order Management System with distributed architecture</li>
  <li>Built and optimized RESTful APIs using Spring Boot and MySQL, resolving 60+ production issues</li>
  <li>Improved frontend performance with modular React components, reducing page response time by 10%</li>
  <li>Configured Redis caching for frequently accessed product data, reducing MySQL query latency by 45%</li>
</ul>

<h2>Technical Skills</h2>

<table>
  <tr><td><strong>Languages</strong></td><td>C/C++, Python, Java, Golang, JavaScript/TypeScript, SQL, R, HTML/CSS</td></tr>
  <tr><td><strong>Backend &amp; Tools</strong></td><td>Spring Boot, Gin, Flask, Node.js, Kafka, RabbitMQ, RESTful APIs, gRPC, Git, Linux</td></tr>
  <tr><td><strong>Cloud &amp; Infra</strong></td><td>AWS (EC2, S3, Lambda, API Gateway, EKS, Glue), Docker, Kubernetes, CI/CD, GitHub Actions</td></tr>
  <tr><td><strong>Databases</strong></td><td>PostgreSQL, MySQL, Redis, MongoDB, Elasticsearch</td></tr>
  <tr><td><strong>ML &amp; AI</strong></td><td>LangChain, RAG, ChromaDB, PySpark, Pandas, NumPy</td></tr>
</table>

<h2>Education</h2>

<p><strong>University of Waterloo</strong> — Candidate of Bachelor of Computer Science, AI Specialization, Statistics Minor<br>
<em>Sept 2023 – May 2028</em></p>
<p>Relevant Courses: Operating Systems, Database, Data Structures and Algorithms, Object-Oriented Programming</p>

<h2>Get In Touch</h2>

<ul>
  <li><a href="mailto:h82wang@uwaterloo.ca">h82wang@uwaterloo.ca</a></li>
  <li><a href="https://www.linkedin.com/in/howard-wang-a7b504280/">LinkedIn</a></li>
  <li><a href="https://github.com/whr129">GitHub</a></li>
  <li><a href="https://www.instagram.com/howardwang0315/">Instagram</a></li>
</ul>
HTMLCONTENT
)" --allow-root

echo "About page updated (ID: ${ABOUT_ID})"

echo "[2/3] Rebuilding navigation menu..."
MENU_EXISTS=$(wp menu list --fields=name --format=csv --allow-root | grep -c "Primary Menu" || true)

if [ "${MENU_EXISTS}" -gt 0 ]; then
    echo "Deleting old Primary Menu..."
    wp menu delete "Primary Menu" --allow-root
fi

wp menu create "Primary Menu" --allow-root

HOME_ID=$(wp post list --post_type=page --title='Home' --field=ID --allow-root)
BLOG_ID=$(wp post list --post_type=page --title='Blog' --field=ID --allow-root)
CONTACT_ID=$(wp post list --post_type=page --title='Contact' --field=ID --allow-root)

PORTFOLIO_CAT_ID=$(wp term list category --name='Portfolio' --field=term_id --allow-root 2>/dev/null || echo "")

wp menu item add-post "Primary Menu" "${HOME_ID}" --title="Home" --allow-root
wp menu item add-post "Primary Menu" "${ABOUT_ID}" --title="About" --allow-root

if [ -n "${PORTFOLIO_CAT_ID}" ]; then
    PORTFOLIO_URL=$(wp option get siteurl --allow-root)/category/portfolio/
    wp menu item add-custom "Primary Menu" "Portfolio" "${PORTFOLIO_URL}" --allow-root
else
    echo "Warning: Portfolio category not found. Run wp-materialize apply first, then re-run this script."
fi

wp menu item add-post "Primary Menu" "${BLOG_ID}" --title="Blog" --allow-root
wp menu item add-post "Primary Menu" "${CONTACT_ID}" --title="Contact" --allow-root

wp menu location assign "Primary Menu" primary --allow-root 2>/dev/null || true
wp menu location assign "Primary Menu" navigation --allow-root 2>/dev/null || true

echo "[3/3] Cleaning up unused pages..."
RESUME_ID=$(wp post list --post_type=page --title='Resume' --field=ID --allow-root 2>/dev/null || echo "")
if [ -n "${RESUME_ID}" ]; then
    echo "Resume page exists (ID: ${RESUME_ID}). Work/education info is now on the About page."
    echo "Delete it manually if you want: wp post delete ${RESUME_ID} --force --allow-root"
fi

echo ""
echo "=== Done ==="
echo "Navigation: Home | About | Portfolio | Blog | Contact"
echo "About page has been populated with your full profile."
