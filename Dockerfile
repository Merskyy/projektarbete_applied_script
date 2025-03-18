# Använd en liten men kompatibel Debian-baserad image
FROM debian:bookworm-slim

# Installera OpenSSH-server
RUN apt-get update && apt-get install -y openssh-server && mkdir -p /var/run/sshd

# Skapa användaren "admin" med lösenord "password"
RUN useradd -m admin && echo "admin:password" | chpasswd

# Skapa tre olika kataloger för konfigurationsfilerna
RUN mkdir -p /etc/config/hostname /etc/config/response /etc/config/interface

# Skapa konfigurationsfiler med fördefinierade värden
RUN echo "hostname: 1" > /etc/config/hostname/config.txt \
    && echo "response_prefix: Standard Response" > /etc/config/response/config.txt \
    && echo "interface_state: down" > /etc/config/interface/config.txt

# Ändra ägarskap och ge skrivbehörighet till katalogerna så att "admin" kan uppdatera filerna
RUN chown -R admin:admin /etc/config \
    && chmod -R 770 /etc/config \
    && chmod -R u+rw /etc/config

# Exponera SSH-porten
EXPOSE 22

# Starta SSH-servern
CMD ["/usr/sbin/sshd", "-D"]

# mac:
# docker build -t simple-ssh-server . 
# docker run -d -p 2222:22 simple-ssh-server

# windows git bash
# docker run -d -p 2222:22 -v $(pwd)/config:/etc/config simple-ssh-server

# windows power shell
# docker run -d -p 2222:22 -v "$(pwd -replace '\', '/')/config:/etc/config" simple-ssh-server

# windows cmd (kommandotolken)
# docker run -d -p 2222:22 -v "%cd%/config:/etc/config" simple-ssh-server




