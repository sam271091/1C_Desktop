
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТЗОбъектов = Новый ТаблицаЗначений;
	ТЗОбъектов.Колонки.Добавить("ТипОбъекта",Новый ОписаниеТипов("Строка"));
	ТЗОбъектов.Колонки.Добавить("ИмяОбъекта",Новый ОписаниеТипов("Строка"));
	ТЗОбъектов.Колонки.Добавить("Видобъекта",Новый ОписаниеТипов("Строка"));
	ТЗОбъектов.Колонки.Добавить("ПредставлениеОбъекта",Новый ОписаниеТипов("Строка"));
	ТЗОбъектов.Колонки.Добавить("Картинка",Новый ОписаниеТипов("Строка"));
	
	СписокСправочники = Метаданные.Справочники;
	
	СписокДокументы = Метаданные.Документы;
	
	СписокОбработки = Метаданные.Обработки;
	
	СписокОчеты = Метаданные.Отчеты;
	Видобъекта = "Справочник";
	Для Каждого Стр из СписокСправочники Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
				
		Если Объектдоступен Тогда 
			
			СтрокаТЗ = ТЗОбъектов.Добавить();
			СтрокаТЗ.ТипОбъекта = "Справочники";
			СтрокаТЗ.ИмяОбъекта = Стр.Имя;
			СтрокаТЗ.Видобъекта = Видобъекта;
			СтрокаТЗ.ПредставлениеОбъекта = Стр.Синоним;
			СтрокаТЗ.Картинка = ПоместитьВоВременноеХранилище(БиблиотекаКартинок.Справочник);
			
		КонецЕсли;
	КонецЦикла;	
	Видобъекта = "Документ";
	Для Каждого Стр из СписокДокументы Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
		Если Объектдоступен Тогда 
			
			СтрокаТЗ = ТЗОбъектов.Добавить();
			СтрокаТЗ.ТипОбъекта = "Документы";
			СтрокаТЗ.ИмяОбъекта = Стр.Имя;
			СтрокаТЗ.Видобъекта = Видобъекта;
			СтрокаТЗ.ПредставлениеОбъекта = Стр.Синоним;
			СтрокаТЗ.Картинка = ПоместитьВоВременноеХранилище(БиблиотекаКартинок.Документ);
		КонецЕсли;
	КонецЦикла;	
	
	Видобъекта = "Обработка";
	Для Каждого Стр из СписокОбработки Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
		Если Объектдоступен Тогда 
			
			СтрокаТЗ = ТЗОбъектов.Добавить();
			СтрокаТЗ.ТипОбъекта = "Обработки";
			СтрокаТЗ.ИмяОбъекта = Стр.Имя;
			СтрокаТЗ.Видобъекта = Видобъекта;
			СтрокаТЗ.ПредставлениеОбъекта = Стр.Синоним;
			СтрокаТЗ.Картинка = ПоместитьВоВременноеХранилище(БиблиотекаКартинок.Обработка);
		КонецЕсли;
	КонецЦикла;	
	Видобъекта = "Отчет";
	Для Каждого Стр из СписокОчеты Цикл 
		Объектдоступен = ПравоДоступа("Просмотр",Стр);
		Если Объектдоступен Тогда 
			
			СтрокаТЗ = ТЗОбъектов.Добавить();
			СтрокаТЗ.ТипОбъекта = "Отчеты";
			СтрокаТЗ.ИмяОбъекта = Стр.Имя;
			СтрокаТЗ.Видобъекта = Видобъекта;
			СтрокаТЗ.ПредставлениеОбъекта = Стр.Синоним;
			СтрокаТЗ.Картинка = ПоместитьВоВременноеХранилище(БиблиотекаКартинок.Отчеты);
		КонецЕсли;
	КонецЦикла;	
	

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ТЗОбъектов",ТЗОбъектов);
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТЗОбъектов.ИмяОбъекта,
	               |	ТЗОбъектов.Видобъекта,
	               |	ТЗОбъектов.ПредставлениеОбъекта,
	               |	ТЗОбъектов.ТипОбъекта,
	               |	ТЗОбъектов.Картинка
	               |ПОМЕСТИТЬ ТЗ
	               |ИЗ
	               |	&ТЗОбъектов КАК ТЗОбъектов";
	Запрос.Выполнить();
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТЗ.ИмяОбъекта,
	               |	ТЗ.Видобъекта,
	               |	ТЗ.ПредставлениеОбъекта,
	               |	ВЫРАЗИТЬ(ТЗ.ТипОбъекта КАК СТРОКА(255)) КАК ТипОбъекта,
	               |	ТЗ.Картинка
	               |ПОМЕСТИТЬ ТЗДляДерева
	               |ИЗ
	               |	ТЗ КАК ТЗ
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ТЗДляДерева.ИмяОбъекта,
	               |	ТЗДляДерева.Видобъекта,
	               |	ТЗДляДерева.ПредставлениеОбъекта,
	               |	ТЗДляДерева.ТипОбъекта КАК ТипОбъекта,
	               |	ТЗДляДерева.Картинка КАК Картинка
	               |ИЗ
	               |	ТЗДляДерева КАК ТЗДляДерева
	               |ИТОГИ
	               |	МАКСИМУМ(Картинка)
	               |ПО
	               |	ТипОбъекта";
	
	
	Выборка = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	ЗначениеВРеквизитФормы(Выборка,"ДеревоОбъектов");
КонецПроцедуры


&НаКлиенте
Процедура ДеревоОбъектовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ТекДанные = Элементы.ДеревоОбъектов.ТекущиеДанные;
	Если ЗначениеЗаполнено(ТекДанные.ИмяОбъекта) Тогда 
		СтруктураДанных = Новый Структура;
		СтруктураДанных.Вставить("ИмяОбъекта",ТекДанные.ИмяОбъекта);
		СтруктураДанных.Вставить("Видобъекта",ТекДанные.Видобъекта);
		СтруктураДанных.Вставить("Представление",ТекДанные.ПредставлениеОбъекта);
		
		Оповестить("ВыборОбъекта",СтруктураДанных);
		ЭтаФорма.Закрыть();
	КонецЕсли;
КонецПроцедуры
