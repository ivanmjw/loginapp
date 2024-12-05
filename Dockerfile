FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Install Python
RUN Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.9.0/python-3.9.0-amd64.exe -OutFile python.exe ; \
    Start-Process python.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -Wait ; \
    Remove-Item python.exe

# Set up working directory
WORKDIR C:\\app

# Install Python dependencies
COPY requirements.txt .
RUN python -m pip install --upgrade pip ; \
    pip install -r requirements.txt

# Copy project files
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["python", "-m", "waitress", "--host=0.0.0.0", "--port=8000", "loginapp.wsgi:application"]