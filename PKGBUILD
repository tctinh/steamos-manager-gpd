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
  'tuned-ppd'
  'acpi_call-dkms'
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
