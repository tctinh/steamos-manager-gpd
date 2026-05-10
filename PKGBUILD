# Maintainer: tctinh
# steamos-manager with native TDP control for GPD Win Mini (ACPI/ALIB)

pkgname=steamos-manager-gpdwinmini
pkgver=26.1.0
pkgrel=1
pkgdesc="SteamOS Manager with native ACPI/ALIB TDP control for GPD Win Mini"
arch=('x86_64')
url="https://gitlab.steamos.cloud/holo/steamos-manager/"
license=('MIT')
depends=(
  'glib2'
  'libspeechd'
  'systemd-libs'
  'dbus'
  'tuned'
)
optdepends=(
  'acpi_call-dkms: Required for GPD Win Mini TDP control via ACPI/ALIB'
  'tuned-ppd: Map KDE/GNOME power-profile selector onto the GPD tuned profiles (replaces power-profiles-daemon)'
)
makedepends=(
  'rust'
  'cargo'
  'clang'
)
provides=('steamos-manager')
conflicts=('steamos-manager')
backup=()
options=(!lto)
install=steamos-manager.install

build() {
  cd "$srcdir/../"
  make build
}

check() {
  cd "$srcdir/../"
  make test
}

package() {
  cd "$srcdir/../"
  make install DESTDIR="$pkgdir"
}
