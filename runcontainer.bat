@echo on
set container_name=%2
set image_name=%3
set port_number=%1

docker ps -a -q --filter name=%container_name% | findstr "." >nul
if %errorlevel% equ 0 (
    docker rm -f %container_name%
    echo Container %container_name% removed.
) 

docker run -d --name %container_name% -p %port_number%:8100 %image_name%
echo Container %container_name% running on port %port_number%.
