&НаКлиенте
Процедура  ПеревозчикВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)	
	Если Элементы.Маршрут.ТекущийЭлемент.Имя = "МаршрутПеревозчик" Тогда 	
		CтандартнаяОбработка = Ложь;
		Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
			Записать();
		КонецЕсли;
		ДанныеМаршрута = ЭтаФорма.ТекущийЭлемент.ТекущиеДанные;	
		СтруктураМаршрута = Новый Структура("");	
		СтруктураМаршрута.Вставить("МЛСсылка", Объект.Ссылка );
		СтруктураМаршрута.Вставить("ДатаПогрузки", ДанныеМаршрута.ДатаПогрузки);
		СтруктураМаршрута.Вставить("ДатаРазгрузки", ДанныеМаршрута.ДатаРазгрузки);
		СтруктураМаршрута.Вставить("НачальнаяТочка", ДанныеМаршрута.НачальнаяТочка);
		СтруктураМаршрута.Вставить("КонечнаяТочка", ДанныеМаршрута.КонечнаяТочка);
		СтруктураМаршрута.Вставить("ЗаявкаНаПеревозку", ДанныеМаршрута.ЗаявкаНаПеревозку);
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеСозданияЗаявки", ЭтаФорма);
		ОткрытьФорму("Документ.ЗаявкаНаПеревозку.Форма.ФормаДокументаМаршрута", СтруктураМаршрута, , , , , ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);	
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура  ПослеСозданияЗаявки(Результат, ДопПараметры) Экспорт
	Если Результат <> Неопределено Тогда 
		ДанныеМаршрута = Элементы.Маршрут.ТекущиеДанные;
		ДанныеМаршрута.Перевозчик = Результат.Перевозчик;
		ДанныеМаршрута.Сумма = Результат.Сумма;
		ДанныеМаршрута.ЗаявкаНаПеревозку = Результат.ЗаявкаНаПеревозку;
		ДанныеМаршрута.Статус = Результат.Статус;
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура МаршрутСтатусПриИзмененииНаСервере(СтруктураМаршрута)
	Если СтруктураМаршрута.ЗаявкаНаПеревозку <> Документы.ЗаявкаНаПеревозку.ПустаяСсылка() Тогда
		Документ = СтруктураМаршрута.ЗаявкаНаПеревозку.ПолучитьОбъект();
		Документ.Статус = СтруктураМаршрута.Статус;
		Документ.Записать();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура МаршрутСтатусПриИзменении(Элемент)
	ДанныеМаршрута = ЭтаФорма.ТекущийЭлемент.ТекущиеДанные;
	СтруктураМаршрута = Новый Структура("");
	СтруктураМаршрута.Вставить("ЗаявкаНаПеревозку", ДанныеМаршрута.ЗаявкаНаПеревозку);
	СтруктураМаршрута.Вставить("Статус", ДанныеМаршрута.Статус);
	МаршрутСтатусПриИзмененииНаСервере(СтруктураМаршрута);
КонецПроцедуры



