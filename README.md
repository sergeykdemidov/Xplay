# XPlay

Запускает видеофайл одновременно на трёх мониторах через [mpv](https://mpv.io/) — с разными смещениями воспроизведения, без звука, в полноэкранном режиме.

## Требования

- Linux, X11
- [mpv](https://mpv.io/) (`sudo apt install mpv`)
- KDE Plasma 6 (Dolphin)
- Python 3 (для `xplay-seek`)

## Установка

```bash
git clone https://github.com/sergeykdemidov/Xplay.git
cd Xplay
chmod +x install.sh
./install.sh
```

`install.sh` копирует скрипты в `~/.local/bin/` и регистрирует пункт контекстного меню в Dolphin.

После установки скрипт выведет команды для ручной настройки глобальных хоткеев в **System Settings → Shortcuts → Custom Shortcuts**.

## Использование

**Через Dolphin:** правая кнопка мыши по видеофайлу → *Play on 3 Monitors (XPlay)*

**Из терминала:**
```bash
xplay /path/to/video.mp4
```

## Скрипты

| Скрипт | Описание |
|---|---|
| `xplay` | Запуск трёх экземпляров mpv |
| `xplay-kill` | Остановить все запущенные экземпляры |
| `xplay-seek <сек>` | Перемотка всех экземпляров (например, `60` или `-60`) |

## Настройка

Параметры задаются в начале `xplay.sh`:

```bash
OFFSET_1="30%"   # смещение для монитора 0
OFFSET_2="50%"   # смещение для монитора 1
OFFSET_3="70%"   # смещение для монитора 2

SCREEN_1=0
SCREEN_2=1
SCREEN_3=2

MPV_OPTS="--vo=gpu --gpu-api=opengl --loop-file"
```

## Удаление

```bash
./uninstall.sh
```

Хоткеи нужно удалить вручную в **System Settings → Shortcuts → Custom Shortcuts**.
