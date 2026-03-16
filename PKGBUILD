# Maintainer: tctinh
# steamos-manager with native TDP control for GPD Win Mini (ACPI/ALIB)

pkgname=steamos-manager
pkgver=26.0.1
pkgrel=2
pkgdesc="SteamOS Manager with native ACPI/ALIB TDP control for GPD Win Mini"
arch=('x86_64')
url="https://gitlab.steamos.cloud/holo/steamos-manager/"
license=('MIT')
depends=(
  'glib2'
  'libspeechd'
  'systemd-libs'
  'dbus'
)
optdepends=(
  'acpi_call-dkms: Required for GPD Win Mini TDP control via ACPI/ALIB'
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
