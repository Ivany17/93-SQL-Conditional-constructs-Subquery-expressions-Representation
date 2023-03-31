class Phone{
  static _client;
  static _tableName = 'phones';

  static async findAll(){
    return this._client.query(`SELECT * FROM "${this._tableName}";`);
  }

  static async bulkCreate(values){
    const valuesString = values
    .map(
      ({brand, model,price,quantity=1})=>
      `('${brand}','${model}','${price}','${quantity}')`
    )
    .join(',');

    const {rows} = await this._client.query(`
      INSERT INTO "${this._tableName}"(
        "brand",
        "model",
        "price",
        "quantity"
      ) VALUES ${valuesString}
      RETURNING *;
    `);
    return rows;
  }
};

module.exports = Phone;