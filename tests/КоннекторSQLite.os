#Использовать ".."

Перем Коннектор;

Процедура ПередЗапускомТеста() Экспорт
	ПодключитьСценарий(ОбъединитьПути(ТекущийКаталог(), "tests", "fixtures", "СущностьСоВсемиТипамиКолонок.os"), "СущностьСоВсемиТипамиКолонок");
	
	Коннектор = Новый КоннекторSQLite();
	СтрокаСоединения = "Data Source=:memory:";
	Коннектор.Открыть(СтрокаСоединения, Новый Массив);
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Коннектор.Закрыть();
КонецПроцедуры

&Тест
Процедура КоннекторSQLiteРеализуетИнтерфейсКоннектора() Экспорт
	// TODO: Рефакторинг
	МенеджерСущностей = Новый МенеджерСущностей(Тип("КоннекторSQLite"));
	МенеджерСущностей.Закрыть();
КонецПроцедуры

&Тест
Процедура Сохранить() Экспорт
	
	МодельДанных = Новый МодельДанных();
	ОбъектМодели = МодельДанных.СоздатьОбъектМодели(Тип("СущностьСоВсемиТипамиКолонок"));
	Коннектор.ИнициализироватьТаблицу(ОбъектМодели);

	ЗависимаяСущность = Новый СущностьСоВсемиТипамиКолонок;
	ЗависимаяСущность.Целое = 2;

	Сущность = Новый СущностьСоВсемиТипамиКолонок;
	Сущность.Целое = 1;
	Сущность.Дробное = 1.2;
	Сущность.БулевоИстина = Истина;
	Сущность.БулевоЛожь = Ложь;
	Сущность.Строка = "Строка";
	Сущность.Дата = Дата(2018, 1, 1);
	Сущность.Время = Дата(1, 1, 1, 10, 53, 20);
	Сущность.ДатаВремя = Дата(2018, 1, 1, 10, 53, 20);
	Сущность.Ссылка = ЗависимаяСущность;
	
	Коннектор.Сохранить(ОбъектМодели, ЗависимаяСущность);
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	ТекстЗапроса = СтрШаблон(
		"SELECT * FROM %1 WHERE %2 = %3", 
		ОбъектМодели.ИмяТаблицы(),
		ОбъектМодели.Идентификатор().ИмяКолонки,
		Сущность.Целое
	);
	РезультатЗапроса = Коннектор.ВыполнитьЗапрос(ТекстЗапроса);
	ДанныеИзБазы = РезультатЗапроса[0];
	
	Ожидаем.Что(ДанныеИзБазы.Целое, "Сущность.Целое сохранилось корректно").Равно(Сущность.Целое);
	Ожидаем.Что(ДанныеИзБазы.Дробное, "Сущность.Дробное сохранилось корректно").Равно(Сущность.Дробное);
	Ожидаем.Что(ДанныеИзБазы.БулевоИстина, "Сущность.БулевоИстина сохранилось корректно").Равно(Сущность.БулевоИстина);
	Ожидаем.Что(ДанныеИзБазы.БулевоЛожь, "Сущность.БулевоЛожь сохранилось корректно").Равно(Сущность.БулевоЛожь);
	Ожидаем.Что(ДанныеИзБазы.Строка, "Сущность.Строка сохранилось корректно").Равно(Сущность.Строка);
	Ожидаем.Что(ДанныеИзБазы.Дата, "Сущность.Дата сохранилось корректно").Равно(Сущность.Дата);
	Ожидаем.Что(ДанныеИзБазы.Время, "Сущность.Время сохранилось корректно").Равно(Сущность.Время);
	Ожидаем.Что(ДанныеИзБазы.ДатаВремя, "Сущность.ДатаВремя сохранилось корректно").Равно(Сущность.ДатаВремя);
	Ожидаем.Что(ДанныеИзБазы.Ссылка, "Сущность.Ссылка сохранилось корректно").Равно(Сущность.Ссылка.Целое);
КонецПроцедуры

&Тест
Процедура ПолучитьЗначенияКолонокСущности() Экспорт
	МодельДанных = Новый МодельДанных();
	ОбъектМодели = МодельДанных.СоздатьОбъектМодели(Тип("СущностьСоВсемиТипамиКолонок"));
	Коннектор.ИнициализироватьТаблицу(ОбъектМодели);
	
	ЗависимаяСущность = Новый СущностьСоВсемиТипамиКолонок;
	ЗависимаяСущность.Целое = 2;
	
	Сущность = Новый СущностьСоВсемиТипамиКолонок;
	Сущность.Целое = 1;
	Сущность.Дробное = 1.2;
	Сущность.БулевоИстина = Истина;
	Сущность.БулевоЛожь = Ложь;
	Сущность.Строка = "Строка";
	Сущность.Дата = Дата(2018, 1, 1);
	Сущность.Время = Дата(1, 1, 1, 10, 53, 20);
	Сущность.ДатаВремя = Дата(2018, 1, 1, 10, 53, 20);
	Сущность.Ссылка = ЗависимаяСущность;
	
	Коннектор.Сохранить(ОбъектМодели, ЗависимаяСущность);
	Коннектор.Сохранить(ОбъектМодели, Сущность);
	
	ЗначенияКолонок = Коннектор.ПолучитьЗначенияКолонокСущности(ОбъектМодели, Сущность.Целое);

	Ожидаем.Что(ЗначенияКолонок.Получить("Целое"), "ЗначенияКолонок.Целое получено корректно").Равно(Сущность.Целое);
	Ожидаем.Что(ЗначенияКолонок.Получить("Дробное"), "ЗначенияКолонок.Дробное получено корректно").Равно(Сущность.Дробное);
	Ожидаем.Что(ЗначенияКолонок.Получить("БулевоИстина"), "ЗначенияКолонок.БулевоИстина получено корректно").Равно(Сущность.БулевоИстина);
	Ожидаем.Что(ЗначенияКолонок.Получить("БулевоЛожь"), "ЗначенияКолонок.БулевоЛожь получено корректно").Равно(Сущность.БулевоЛожь);
	Ожидаем.Что(ЗначенияКолонок.Получить("Строка"), "ЗначенияКолонок.Строка получено корректно").Равно(Сущность.Строка);
	Ожидаем.Что(ЗначенияКолонок.Получить("Дата"), "ЗначенияКолонок.Дата получено корректно").Равно(Сущность.Дата);
	Ожидаем.Что(ЗначенияКолонок.Получить("Время"), "ЗначенияКолонок.Время получено корректно").Равно(Сущность.Время);
	Ожидаем.Что(ЗначенияКолонок.Получить("ДатаВремя"), "ЗначенияКолонок.ДатаВремя получено корректно").Равно(Сущность.ДатаВремя);
	Ожидаем.Что(ЗначенияКолонок.Получить("Ссылка"), "ЗначенияКолонок.Ссылка получено корректно").Равно(Сущность.Ссылка.Целое);
КонецПроцедуры

// TODO: Больше тестов на непосредственно коннектор
