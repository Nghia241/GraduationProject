# Puma có thể phục vụ mỗi request bằng một luồng trong pool nội bộ.
# Cài đặt `threads` nhận hai số: giá trị tối thiểu và tối đa.
# Các thư viện sử dụng pool luồng nên được cấu hình để phù hợp với giá trị tối đa được chỉ định.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 16 } # Tăng luồng tối đa lên 16
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { 4 }  # Luồng tối thiểu là 4
threads min_threads_count, max_threads_count

# Thời gian chờ của worker trong môi trường phát triển.
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Cổng mà Puma sẽ lắng nghe để nhận yêu cầu; mặc định là 3000.
port ENV.fetch("PORT") { 3000 }

# Môi trường mà Puma sẽ chạy.
environment ENV.fetch("RAILS_ENV") { "development" }

# Tệp `pidfile` mà Puma sẽ sử dụng.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Số lượng worker sẽ khởi động trong chế độ cluster.
# Mỗi worker là một tiến trình server độc lập.
workers ENV.fetch("WEB_CONCURRENCY") { 2 } # Khởi tạo 2 worker để xử lý đa tiến trình.

# Sử dụng phương thức `preload_app!` khi chỉ định số lượng worker.
# Phương thức này sẽ tải toàn bộ ứng dụng trước khi fork các worker mới.
preload_app!

# Cho phép Puma được khởi động lại bởi lệnh `bin/rails restart`.
plugin :tmp_restart
