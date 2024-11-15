FROM python:3-slim-buster

RUN pip install --upgrade pip

ENV USER botx
ENV HOME /home/$USER
ENV BOT $HOME/media-search-bot

RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Create a non-root user and directory for the bot
RUN useradd -m botx
RUN mkdir -p /home/botx/media-search-bot
RUN chown botx:botx /home/botx/media-search-bot
WORKDIR /home/botx/media-search-bot

# Switch to the non-root user
USER botx


COPY requirements.txt requirements.txt
RUN pip install --user --no-cache-dir -r requirements.txt

COPY . .

CMD python3 bot.py

