# Kubernetes Microservices Project

This project demonstrates a Kubernetes-based microservices architecture using three deployments:
- **Frontend 1 (Nginx)**: Exposed as an external service.
- **Frontend 2 (Apache)**: Exposed as an internal service.
- **Backend (PostgreSQL)**: Exposed as an internal service.

The goal is to implement and demonstrate Kubernetes concepts such as deployments, services, config maps, secrets, and Docker containers.

## Architecture

### Components
1. **Nginx Frontend**:
   - A web server exposed externally using a `LoadBalancer` service.
2. **Apache Frontend**:
   - Another web server exposed internally using a `ClusterIP` service.
3. **PostgreSQL Backend**:
   - A database deployment exposed internally using a `ClusterIP` service.

### Kubernetes Objects
- **Deployments**: Manage replicas and ensure desired state.
- **Services**: Enable connectivity between microservices.
- **Config Maps**: Store non-sensitive database configuration (e.g., `DB_HOST`, `DB_NAME`).
- **Secrets**: Store sensitive database credentials (`DB_USER`, `DB_PASSWORD`).

#### **10.3: Steps to Deploy**
Provide detailed steps to deploy the resources:
```markdown
## Steps to Deploy

1. **Pre-requisites**:
   - Kubernetes cluster setup (e.g., Docker Desktop, Minikube).
   - kubectl installed and configured.
   - Docker installed for building custom images.

2. **Setup Backend (PostgreSQL)**:
   - Create secrets for database credentials:
     ```bash
     kubectl apply -f db-secrets.yaml
     ```
   - Create config maps for database configuration:
     ```bash
     kubectl apply -f db-config.yaml
     ```
   - Deploy PostgreSQL backend:
     ```bash
     kubectl apply -f postgres-deployment.yaml
     ```

3. **Setup Frontend (Nginx and Apache)**:
   - Deploy Nginx frontend:
     ```bash
     kubectl apply -f nginx-deployment.yaml
     ```
   - Deploy Apache frontend:
     ```bash
     kubectl apply -f apache-deployment.yaml
     ```

4. **Verify Deployments**:
   - Check the status of pods:
     ```bash
     kubectl get pods
     ```
   - Verify services:
     ```bash
     kubectl get services
     ```

---

#### **10.4: Access Instructions**
Explain how to access the services:
```markdown
## Access Instructions

1. **Nginx Frontend**:
   - Open your browser and navigate to `http://localhost:<port>`.
   - Port can be obtained using:
     ```bash
     kubectl get service nginx-service
     ```

2. **Apache Frontend**:
   - Apache is accessible only within the cluster.
   - Use a temporary pod to test:
     ```bash
     kubectl run test-pod --image=curlimages/curl -it --rm --restart=Never -- sh
     curl http://apache-service
     exit
     ```

3. **Backend (PostgreSQL)**:
   - Internal service accessible by frontends. Connection configuration is managed using `db-config` and `db-secrets`.
   - Run the following commands to access & verify the database :
     ```bash
     kubectl run test-pod --image=postgres:latest -it --rm --restart=Never -- bash
     psql -h postgres-service -U <DB_USER> -d <DB_NAME>
     ```
   - Replace <DB_USER> and <DB_NAME> with the actual values. Credentials are stored in the db-credentials secret and db-config config map.
   - Now run SQL commands to verify DB contents.

## Notes on Configurations

- **Custom Docker Images**:
  - PostgreSQL uses the `init.sql` script to set up initial database tables.

- **Secrets**:
  - Ensure sensitive data (like `DB_USER` and `DB_PASSWORD`) are stored securely in Kubernetes secrets.

- **Testing**:
  - This setup uses default Nginx and Apache pages for simplicity.
  - Custom apps can be added by modifying the respective Dockerfiles.

- **Troubleshooting**:
  - If pods fail to start, check logs using:
    ```bash
    kubectl logs <pod-name>
    ```
