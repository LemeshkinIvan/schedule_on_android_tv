class ModelOfTableHeaders {
  final String columnName;
  final int flexFactor;

  const ModelOfTableHeaders(this.columnName, this.flexFactor);

  static List<ModelOfTableHeaders> getOperationTableHeaders() {
    return [
      const ModelOfTableHeaders("Пара", 1),
      const ModelOfTableHeaders("Группа", 1),
      const ModelOfTableHeaders("Предмет", 1),
      const ModelOfTableHeaders("Кабинет", 1),
      const ModelOfTableHeaders("Преподаватель", 1),
      const ModelOfTableHeaders("Зам.предмет", 1),
      const ModelOfTableHeaders("Зам.кабинет", 1),
      const ModelOfTableHeaders("Зам.преподаватель", 1),
    ];
  }
}
