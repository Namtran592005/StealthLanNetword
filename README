# ARP Stealth Toolkit

## Giới thiệu
ARP Stealth Toolkit là bộ công cụ giúp **ẩn máy tính khỏi các thiết bị khác trong mạng LAN** (ngoại trừ router) và tăng cường bảo mật mạng trong các môi trường không đáng tin cậy, như Wi-Fi công cộng. Bộ công cụ bao gồm các tệp sau:

- **`arp_stealth.py`**: Script Python sử dụng Scapy để lọc các yêu cầu ARP, chỉ phản hồi cho router, khiến máy tính "tàng hình" với các thiết bị khác trong mạng LAN.
- **`stealth.bat`**: Tệp batch Windows để kích hoạt chế độ ẩn danh mạng, tắt các dịch vụ khám phá (như SSDP, UPnP), chặn các cổng dễ bị tấn công (như SMB, RDP), và giảm dấu vết mạng.
- **`restore.bat`**: Tệp batch Windows để khôi phục các thiết lập mạng về trạng thái mặc định, bật lại các dịch vụ và xóa các quy tắc tường lửa được tạo bởi `stealth.bat`.
- **`install_task.bat`**: Tệp batch Windows để tạo một tác vụ tự động chạy `arp_stealth.exe` (phiên bản đã biên dịch của `arp_stealth.py`) khi đăng nhập, đảm bảo chế độ ẩn danh ARP luôn hoạt động.

Bộ công cụ này rất hữu ích trong các môi trường mạng công cộng (quán cà phê, sân bay, khách sạn) để bảo vệ máy tính khỏi các cuộc quét mạng, tấn công, hoặc giám sát.

## Yêu cầu
- **Hệ điều hành**: Windows (Windows 10 hoặc mới hơn được khuyến nghị).
- **Quyền quản trị viên**: Cần chạy các tệp batch (`stealth.bat`, `restore.bat`, `install_task.bat`) với quyền **Run as Administrator**.
- **Python và Scapy** (cho `arp_stealth.py`):
  - Python 3.x.
  - Thư viện Scapy (`pip install scapy`).
  - Nếu sử dụng `arp_stealth.exe`, không cần cài đặt Python/Scapy.
- **Tường lửa Windows**: Phải được bật để các quy tắc trong `stealth.bat` có hiệu lực.
- **Kết nối mạng**: Máy tính cần kết nối với router qua Wi-Fi hoặc Ethernet.

## Hướng dẫn cài đặt
1. **Cài đặt Python và Scapy (nếu sử dụng `arp_stealth.py`)**:
   - Tải và cài đặt Python từ [python.org](https://www.python.org).
   - Mở Command Prompt và chạy:
     ```
     pip install scapy
     ```
   - Lưu ý: Nếu sử dụng `arp_stealth.exe` (phiên bản đã biên dịch), bỏ qua bước này.

2. **Tải bộ công cụ**:
   - Tải toàn bộ thư mục chứa các tệp `arp_stealth.py` (hoặc `arp_stealth.exe`), `stealth.bat`, `restore.bat`, và `install_task.bat`.
   - Đặt tất cả các tệp trong cùng một thư mục để dễ quản lý.

3. **Chuẩn bị**:
   - Đảm bảo bạn có quyền quản trị viên.
   - Kiểm tra kết nối mạng (Wi-Fi hoặc Ethernet) và đảm bảo máy tính có thể giao tiếp với router.

## Hướng dẫn sử dụng
### 1. Kích hoạt chế độ ẩn danh
- **Chạy `stealth.bat`**:
  - Nhấp chuột phải vào `stealth.bat` và chọn **Run as Administrator**.
  - Script sẽ:
    - Tắt các dịch vụ khám phá mạng (SSDP, UPnP, FDResPub, v.v.).
    - Chặn các cổng dễ bị tấn công (ICMP, NetBIOS, SMB, RDP, v.v.) qua tường lửa.
    - Vô hiệu hóa đăng ký hostname với DHCP và đặt TTL = 1 để giảm dấu vết mạng.
  - Lưu ý: Một số tính năng mạng (như chia sẻ tệp, in ấn) có thể bị vô hiệu hóa.

- **Chạy `arp_stealth.py` hoặc `arp_stealth.exe`**:
  - Nếu sử dụng `arp_stealth.py`, mở Command Prompt với quyền quản trị viên và chạy:
    ```
    python arp_stealth.py
    ```
  - Nếu sử dụng `arp_stealth.exe`, nhấp đúp để chạy (yêu cầu quyền quản trị viên).
  - Script sẽ lọc các yêu cầu ARP, chỉ phản hồi cho router, khiến máy tính "tàng hình" với các thiết bị khác trong mạng LAN.

- **Tự động chạy `arp_stealth.exe`**:
  - Nhấp chuột phải vào `install_task.bat` và chọn **Run as Administrator**.
  - Tệp này tạo một tác vụ tự động chạy `arp_stealth.exe` khi đăng nhập, đảm bảo chế độ ẩn danh ARP luôn hoạt động.
  - Đảm bảo `arp_stealth.exe` nằm trong cùng thư mục với `install_task.bat`.

### 2. Khôi phục thiết lập gốc
- **Chạy `restore.bat`**:
  - Nhấp chuột phải vào `restore.bat` và chọn **Run as Administrator**.
  - Script sẽ:
    - Xóa các quy tắc tường lửa được tạo bởi `stealth.bat`.
    - Khôi phục các dịch vụ mạng (SSDP, UPnP, LanmanServer, v.v.) về trạng thái mặc định.
    - Khôi phục đăng ký hostname với DHCP và đặt TTL về 128.
  - Lưu ý: Có thể cần khởi động lại máy tính để áp dụng đầy đủ các thay đổi.

### 3. Gỡ bỏ tác vụ tự động
- Nếu không muốn `arp_stealth.exe` chạy tự động khi đăng nhập, mở Command Prompt với quyền quản trị viên và chạy:
  ```
  schtasks /delete /tn "ARP Stealth Filter" /f
  ```

## Lưu ý quan trọng
- **Sử dụng VPN để tăng cường bảo mật**: Kết hợp với VPN (như Cloudflare WARP 1.1.1.1) để mã hóa lưu lượng mạng, đặc biệt trong mạng công cộng.
- **Ảnh hưởng đến chức năng mạng**: `stealth.bat` tắt các dịch vụ như chia sẻ tệp/in ấn và RDP. Chỉ sử dụng trong các mạng không đáng tin cậy và chạy `restore.bat` khi trở về mạng an toàn.
- **TTL = 1 có thể gây vấn đề**: Giá trị TTL = 1 trong `stealth.bat` có thể làm gián đoạn kết nối internet với một số dịch vụ. Để cải thiện, chỉnh sửa `stealth.bat` để đặt `defaultcurhoplimit=64` thay vì 1:
  ```
  netsh int ipv4 set global defaultcurhoplimit=64
  ```
- **Kiểm tra hiệu quả**: Sử dụng công cụ như `nmap` từ một máy khác trong mạng để kiểm tra xem máy của bạn có thực sự "tàng hình" không:
  ```
  nmap -sn <your_ip>
  ```
- **Cập nhật hệ thống**: Đảm bảo Windows và các phần mềm (bao gồm Python, Scapy) được cập nhật để tránh lỗ hổng bảo mật.
- **Sao lưu**: Luôn giữ bản sao lưu của các thiết lập mạng gốc trước khi chạy `stealth.bat`.

## Hạn chế
- **Phụ thuộc vào router**: Nếu router bị xâm nhập, chế độ ẩn danh ARP sẽ không hiệu quả.
- **Hiệu suất**: Chạy `arp_stealth.py` liên tục có thể tiêu tốn CPU/RAM trên máy cấu hình thấp.
- **Không bảo vệ trước các mối đe dọa ngoài mạng**: Bộ công cụ không chống lại phần mềm độc hại hoặc lỗ hổng phần mềm. Kết hợp với phần mềm chống virus và VPN để bảo vệ toàn diện.

## Hỗ trợ
Nếu gặp vấn đề hoặc cần hỗ trợ, hãy:
- Kiểm tra tài liệu Scapy tại [scapy.readthedocs.io](https://scapy.readthedocs.io).
- Tìm kiếm trên các diễn đàn bảo mật mạng hoặc liên hệ quản trị viên hệ thống.

## Tác giả
Bộ công cụ được phát triển để tăng cường bảo mật mạng trong các môi trường công cộng. Đóng góp hoặc báo lỗi xin gửi về [liên hệ của bạn, nếu có].
