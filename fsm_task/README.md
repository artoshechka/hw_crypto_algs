# Конечный автомат — распознавание имени

- Тип автомата: Мили
- Распознаваемая последовательность: `ANTON`
- Разрядность входа: 8 бит
- Разрядность выхода: 1 бит

Выход `detected` принимает значение `1` на том такте, когда очередной входной символ завершает последовательность. Диаграммы переходов сохранены в форматах [PlantUML](name_mealy.puml) и [Graphviz DOT](name_mealy.dot).

SystemVerilog-модуль: [rtl/name_mealy_fsm.sv](rtl/name_mealy_fsm.sv)

Тестбенч: [sim/tb_name_mealy_fsm.sv](sim/tb_name_mealy_fsm.sv). Он выполняет
обход переходов из каждого состояния и проверяет результат через `assert`.

Проект Gowin EDA: [fsm_task.gprj](fsm_task.gprj). В проект для синтеза
добавлен только RTL-модуль, тестбенч используется отдельно для симуляции.

## Запуск

Из каталога модуля:

```console
cd fsm_task/sim
make all
make wave
```

Для тестового запуска достаточно:

```console
cd fsm_task/sim
make sim
```
