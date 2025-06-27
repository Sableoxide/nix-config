# NixOS Configuration Flake

A **declarative** NixOS system and Home Manager configuration using **Nix Flakes** for reproducibility.

## 📦 Features
- **NixOS** system configuration (`configuration.nix`)  
- **Home Manager** user environment (`home.nix`)  
- **Flake-based** for pinning dependencies  
- Supports **unfree packages** (e.g., Steam, Discord, vscode)  

## ⚙️ Setup

## ⚠️ NOTE FIRST
- Replace `sableoxide` with your **username** in `flake.nix and connfiguration.nix` and commands.  
- Replace `nixos-btw` with your **hostname** in `flake.nix and connfiguration.nix` and commands.  
- Edit or use your own `configuration.nix` and `home.nix` to match your needs.  

### Prerequisites
- NixOS (with `flakes` and `nix-command` enabled)  
- Home Manager (I followed this https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module to install home-manager)  

### Usage
1. **Clone the repository**:
   ```bash
   # clone into your home Directory(or anywhere else Note: you may have to change hms & nrs alias)
   git clone https://github.com/your-username/nixos-config.git
   cd nixos-config
   ```

2. **Deploy the NixOS system** (as root):
   ```bash
   sudo nixos-rebuild switch --flake .#nixos-btw
   ```

3. **Deploy Home Manager** (as user):
   ```bash
   home-manager switch --flake .#sableoxide@nixos-btw
   # incase of conflict errors try:
   # home-manager switch -b backup --flake .#sableoxide@nixos-btw
   ```

## 🔄 Updating
- Update all flake inputs:
  ```bash
  nix flake update
  ```
- Rebuild after updates:
  ```bash
  sudo nixos-rebuild switch --flake .#nixos-btw
  home-manager switch --flake .#sableoxide@nixos-btw
  # incase of conflict errors try:
  # home-manager switch -b backup --flake .#sableoxide@nixos-btw
  ```

  

### Key Additions(for this readme):
- Clear **setup instructions** for NixOS + Home Manager.  
- **Commands** for deployment/updates.  
- **Directory structure** explanation.  
- Placeholders for customization (username, configs).  
