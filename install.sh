#!/bin/bash

# Actualizar los paquetes del sistema
echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar herramientas básicas de desarrollo y utilidades
echo "Instalando git, gcc y fastfetch..."
sudo pacman -S --noconfirm git gcc fastfetch

# Instalar Hyprland, Alacritty y Chromium
echo "Instalando Hyprland, Alacritty y Chromium..."
sudo pacman -Sy --noconfirm hyprland alacritty chromium

# Instalar Waybar
echo "Instalando Waybar..."
sudo pacman -Sy --noconfirm waybar

# Instalar fuentes Nerd Fonts
echo "Instalando Nerd Fonts..."
sudo pacman -Sy --noconfirm nerd-fonts

# Instalar git y base-devel (utilizados comúnmente para compilación)
echo "Instalando git y base-devel..."
sudo pacman -Sy --noconfirm git base-devel

# Instalar Bluez, Bluez-utils y Blueman para gestión de Bluetooth
echo "Instalando Bluez, Bluez-utils y Blueman..."
sudo pacman -Sy --noconfirm bluez bluez-utils blueman

# Habilitar y arrancar el servicio de Bluetooth
echo "Habilitando y arrancando el servicio de Bluetooth..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Instalar Wayland, Xorg Server y Xwayland
echo "Instalando Wayland, Xorg y Xwayland..."
sudo pacman -S --noconfirm wayland xorg-server xorg-xwayland

# Crear y editar el archivo .xinitrc para usar Hyprland
echo "Configurando .xinitrc..."
echo "exec Hyprland" > ~/.xinitrc

# Crear el servicio systemd para Hyprland
echo "Creando el servicio systemd para Hyprland..."
mkdir -p ~/.config/systemd/user
cat <<EOF > ~/.config/systemd/user/hyprland.service
[Unit]
Description=Hyprland Session
After=graphical.target

[Service]
ExecStart=/usr/bin/Hyprland
Restart=always
User=$USER
Environment=DISPLAY=:0

[Install]
WantedBy=default.target
EOF

# Habilitar y arrancar el servicio systemd de Hyprland
echo "Habilitando y arrancando el servicio Hyprland..."
systemctl --user enable hyprland.service
systemctl --user start hyprland.service

# Instalar SDDM
echo "Instalando SDDM..."
sudo pacman -S --noconfirm sddm

# Habilitar el servicio de SDDM
echo "Habilitando SDDM..."
sudo systemctl enable sddm.service

# Instalar Zsh
echo "Instalando Zsh..."
sudo pacman -Sy --noconfirm zsh

# Instalar Oh My Zsh
echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar Starship
echo "Instalando Starship..."
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Instalar Zsh Syntax Highlighting
echo "Instalando Zsh Syntax Highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Fuente el archivo de Zsh Syntax Highlighting
echo "Fuente el archivo de Zsh Syntax Highlighting..."
source ~/.zshrc

# Instalar yay (AUR helper)
echo "Instalando yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Volver al directorio anterior
cd ..

# Instalar rofi-wayland usando yay
echo "Instalando rofi-wayland..."
yay -S --noconfirm rofi-wayland

# Clonar el repositorio de rofi-themes-collection
echo "Clonando rofi-themes-collection..."
git clone https://github.com/lr-tech/rofi-themes-collection.git

# Copiar el tema spotlight-dark.rasi
echo "Copiando el tema spotlight-dark.rasi..."
cd rofi-themes-collection
mkdir -p ~/.local/share/rofi/themes/
cp themes/spotlight-dark.rasi ~/.local/share/rofi/themes/

# Instalar swww desde AUR usando yay
echo "Instalando swww desde AUR..."
yay -S --noconfirm swww

# Instalar hyprpaper desde pacman
echo "Instalando hyprpaper..."
sudo pacman -Sy --noconfirm hyprpaper

# Instalar dependencias adicionales para Hyprland
echo "Instalando dependencias adicionales para Hyprland..."
sudo pacman -S --noconfirm ninja gcc wayland-protocols libjpeg-turbo libwebp libjxl pango cairo pkgconf cmake libglvnd wayland hyprutils hyprwayland-scanner hyprlang

# Copiar la carpeta completa de configuración de Alacritty
cp -rf ~/.config/alacritty/ ~/.config/alacritty/

# Copiar la carpeta completa de configuración de Hyprland
cp -rf ~/.config/hyprland/ ~/.config/hypr/

# Copiar la carpeta completa de configuración de Rofi
cp -rf ~/.config/rofi/ ~/.config/rofi/

# Copiar la carpeta completa de configuración de Waybar
cp -rf ~/.config/waybar/ ~/.config/waybar/

# Copiar la carpeta completa de configuración de Starship
cp -rf ~/.config/starship/ ~/.config/starship/

# Copiar el archivo de configuración de Starship
echo "Configurando Starship..."
cp -f starship.toml ~/.config/starship.toml


echo "¡Proceso completado con éxito!"
