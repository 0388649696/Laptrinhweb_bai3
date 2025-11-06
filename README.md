# Laptrinhweb_bai3
1. Khởi chạy cmd với adminitor và thiết lập wsl:
Chạy lệnh wls -install :
<img width="1352" height="912" alt="image" src="https://github.com/user-attachments/assets/5527cf03-e4f4-4347-9455-17d7e26884c5" /> .
- Window+R chạy optionalfeatures để mở Windows features. Tìm đến Virtul Machine Platform
<img width="1062" height="637" alt="image" src="https://github.com/user-attachments/assets/65530457-861b-478f-b335-e975e435fc6f" /> .
và cả Windows Subsystem for Linux
<img width="558" height="493" alt="image" src="https://github.com/user-attachments/assets/4e4c2288-8eed-4adb-b9ad-2f3eaeb79156" /> .
 Bật 2 cái đấy lên.

## 2. Cài đặt môi trường linux: docker desktop
   Chọn phương án 1 như sau:
- <img width="874" height="598" alt="image" src="https://github.com/user-attachments/assets/550bff39-8153-4576-be6a-4e53a76793da" /> .
- trước tiên bắt buộc cài đặt xong Docker Desktop

 - Giao diện mở Docker lên:
<img width="1594" height="1011" alt="image" src="https://github.com/user-attachments/assets/41f2cd92-7fd1-443d-82cf-ebc4a59c5c60" />

## 3. Tạo dự án mới.
 - Đây đặt dự án tên là webbt3.
 - Lần đầu chạy lệnh docker-compose up -d để tải và sử dụng docker với nó.
 - <img width="921" height="1008" alt="image" src="https://github.com/user-attachments/assets/891863ae-1c9d-436b-8dbf-7a2357787f34" />
 -  Đến khi các Containers khởi động và Đang chạy hết thì được
<img width="1562" height="867" alt="image" src="https://github.com/user-attachments/assets/c8096381-52e4-4f60-b2a3-61b0821093e6" />

+ Cấu hình docker-compose.yml:
  - Chạy lệnh: nano docker-compose.yml
  - Cấu hình trông như sau:

  version: "3.8"

services:
  mariadb:
    image: mariadb:10.11
    container_name: mariadb
    restart: unless-stopped
    environment:
      # SỬ DỤNG GIÁ TRỊ CỐ ĐỊNH
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_DATABASE: web
      MYSQL_USER: anhtu
      MYSQL_PASSWORD: 123456
    ports:
      - "3306:3306"
    volumes:
      - ./mariadb_data:/var/lib/mysql
    healthcheck:
      # SỬ DỤNG GIÁ TRỊ CỐ ĐỊNH TRONG LỆNH PING
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p123456"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - iot_network

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin
    restart: unless-stopped
    environment:
      PMA_HOST: mariadb
      PMA_PORT: 3306
      PMA_USER: root
      # SỬ DỤNG GIÁ TRỊ CỐ ĐỊNH
      PMA_PASSWORD: 123456
      PMA_ARBITRARY: 1
    ports:
      - "8081:80"
    depends_on:
      mariadb:
        condition: service_healthy
    networks:
      - iot_network

  nodered:
    image: nodered/node-red:latest
    container_name: nodered
    restart: unless-stopped
    ports:
      - "1880:1880"
    volumes:
      - ./nodered_data:/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:1880/"]
      interval: 30s
      timeout: 10s
      retries: 3
    networks:
      - iot_network

  influxdb:
    image: influxdb:2.7
    container_name: influxdb
    restart: unless-stopped
    ports:
      - "8086:8086"
    environment:
      DOCKER_INFLUXDB_INIT_MODE: setup
      DOCKER_INFLUXDB_INIT_USERNAME: admin
      # SỬ DỤNG GIÁ TRỊ CỐ ĐỊNH
      DOCKER_INFLUXDB_INIT_PASSWORD: admin123
      DOCKER_INFLUXDB_INIT_ORG: iot_org
      DOCKER_INFLUXDB_INIT_BUCKET: iot_bucket
      # SỬ DỤNG GIÁ TRỊ CỐ ĐỊNH
      DOCKER_INFLUXDB_INIT_ADMIN_TOKEN: my-token
    volumes:
      - ./influxdb_data:/var/lib/influxdb2
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8086/health"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - iot_network

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    restart: unless-stopped
    ports:
      - "3000:3000"
    depends_on:
      - influxdb
    volumes:
      - ./grafana_data:/var/lib/grafana
    environment:
      GF_SECURITY_ADMIN_USER: admin
      # SỬ DỤNG GIÁ TRỊ CỐ ĐỊNH
      GF_SECURITY_ADMIN_PASSWORD: admin123
      GF_USERS_ALLOW_SIGN_UP: "false"
    healthcheck:
      test: ["CMD", "wget", "-q", "-O", "/dev/null", "http://localhost:3000/api/health"]
      interval: 15s
      timeout: 5s
      retries: 3
    networks:
      - iot_network

  nginx:
    image: nginx:latest
    container_name: nginx
    restart: unless-stopped
    ports:
      - "8088:80"
      - "4443:443"
    volumes:
      # LƯU Ý: Nginx mặc định dùng conf.d/default.conf, tôi sẽ dùng tên file này.
##### Đảm bảo file cấu hình là ./nginx/nginx.conf
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro 
      - ./nginx/html:/usr/share/nginx/html:ro
    depends_on:
      - grafana
      - nodered
      - phpmyadmin
    networks:
      - iot_network

networks:
  iot_network:
    driver: bridge


## 4. Web form - Backend:

   
