FROM jpconstantineau/arduino-cli:latest 

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y libc6:i386 && rm -rf /var/lib/apt/lists/*
RUN ./arduino-cli core update-index
RUN ./arduino-cli core upgrade
RUN ./arduino-cli core list
RUN ./arduino-cli core search nrf52
RUN ./arduino-cli board listall
RUN pip3 install adafruit-nrfutil
RUN ./arduino-cli core install adafruit:nrf52
RUN ./arduino-cli core list
RUN ./arduino-cli board listall
COPY test.ino /home
RUN ./arduino-cli compile -v --fqbn adafruit:nrf52:feather52832 --build-path /tmp /home/test.ino -o test
