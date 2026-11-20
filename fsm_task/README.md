# Автомат Мили для распознавания имени

## Что сделано

Автомат распознаёт последовательность `ANTON`, передаваемую по одному символу
за такт в кодировке ASCII.

- тип автомата: Мили;
- ширина входа: 8 бит;
- ширина выхода: 1 бит;
- `detected_` становится равен `1` при получении последней буквы `N`.

После распознавания имени автомат возвращается в начальное состояние `S0`.
Если входной символ не продолжает имя, автомат возвращается в `S0` либо
сохраняет префикс `A`, если текущий символ может начать новое совпадение.

## Файлы

- RTL-модуль: [rtl/name_mealy_fsm.sv](rtl/name_mealy_fsm.sv);
- тестбенч: [sim/tb_name_mealy_fsm.sv](sim/tb_name_mealy_fsm.sv);
- корректная последовательность: [sim/sequence_correct.tv](sim/sequence_correct.tv);
- некорректные последовательности: [sim/sequence_incorrect.tv](sim/sequence_incorrect.tv);
- тестовые векторы: [sim/sequence_full_path.tv](sim/sequence_full_path.tv);
- диаграмма Graphviz: [name_mealy.dot](name_mealy.dot);
- диаграмма SVG: [name_mealy.svg](name_mealy.svg);
- проект Gowin EDA: [fsm_task.gprj](fsm_task.gprj).

Тестбенч выполняет обход переходов из каждого состояния и автоматически
проверяет выход и новое состояние через `assert`.

## Запуск

Линтинг и форматирование из корня репозитория:

```console
make -C fsm_task lint-all
make -C fsm_task format
```

Симуляция:

```console
make -C fsm_task/sim sim TEST=sequence_correct.tv
make -C fsm_task/sim sim TEST=sequence_incorrect.tv
make -C fsm_task/sim sim TEST=sequence_full_path.tv
make -C fsm_task/sim wave
```

После запуска `make sim` файл waveform находится в `sim/work/wave.ocd`.

## Сохранение настроек waveform

Чтобы не добавлять сигналы в GTKWave вручную после каждого запуска, настройки
сохраняются в отдельном файле `fsm_task/wave.gtkw`:

1. Откройте waveform командой `make -C fsm_task/sim wave`.
2. Добавьте в GTKWave нужные сигналы, например `data_`, `detected_`,
   `stateDbg_`, `clk_` и `rst_`.
3. Выберите `File -> Write Save File` или нажмите `Ctrl+S`.
4. Сохраните файл как `fsm_task/wave.gtkw`.

Не сохраняйте `.gtkw` в каталоге `sim/work`, потому что `make clean` удаляет
этот каталог.

После этого `make wave` будет автоматически открывать `wave.gtkw`. Сам файл
не генерируется заново и не удаляется командой `make clean`.
