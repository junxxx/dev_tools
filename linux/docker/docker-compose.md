```
version: '3.8'

services:
  sql-server:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: sql-server-container
    restart: unless-stopped
    environment:
      - ACCEPT_EULA=Y
      - SA_PASSWORD=YourStrong!Passw0rd
      - MSSQL_PID=Developer
      - MSSQL_AGENT_ENABLED=True
    ports:
      - "1433:1433"
    volumes:
      - sql-server-data:/var/opt/mssql
      - ./backups:/var/opt/mssql/backups
      - ./scripts:/scripts
    networks:
      - sql-network

volumes:
  sql-server-data:
    name: sql-server-data

networks:
  sql-network:
    name: sql-network
    driver: bridge
```

```
# Start the container
docker-compose up -d

# Stop the container
docker-compose down

# View logs
docker-compose logs -f

```
