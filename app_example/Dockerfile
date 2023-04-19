FROM python:3.10 as build
# Install system build requirements
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential \
        gcc
# Copy python dependencies file
COPY requirements.txt .
# Install dependencies to user directory (i.e. default is root)
RUN pip install --user --no-warn-script-location \
    --no-cache-dir -r ./requirements.txt



FROM python:3.10 as runtime
# Python specific environment variables for containers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PATH="/home/appuser/.local/bin:$PATH"
# Copy dependencies from build stage above
COPY --from=build \
    /root/.local \
    /home/appuser/.local
# Set current working directory (permanently)
WORKDIR /app
# Copy your app server code
COPY main.py .
# Pre-compile deps to .pyc, add mastapi user, permissions
RUN python -c "import compileall; compileall.compile_path(maxlevels=10, quiet=1)" \
    && useradd -r -u 900 -m -c "appuser account" -d /home/appuser -s /bin/false appuser \
    && chown -R appuser:appuser /opt /home/appuser



# The debug server config
FROM runtime as debug
RUN pip install --no-cache-dir debugpy==1.6.7
USER appuser
ENTRYPOINT ["python", "-m", "debugpy", "--wait-for-client", "--listen", \
            "0.0.0.0:5678", "-m"]
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", \
    "--reload", "--log-level", "error", "--no-access-log"]



# The production server config
FROM runtime as prod
USER appuser
ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
CMD ["--workers", "1", "--log-level", "error", "--no-access-log"]
