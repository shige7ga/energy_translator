# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
conversions = [
  {
    name: 'ウォーキング',
    description: '体重60kgの人が普通の速さ(時速約4km)で歩いた場合の消費カロリー目安',
    category: '運動',
    input_unit: 'kcal',
    output_unit: '分',
    factor: 3.0,
    calculation_type: :divide,
    reference_url: 'https://www.nibn.go.jp/activities/documents/2024Compendium_table_adult_ver1_1_5.pdf',
    icon: '🚶‍♂️'
  },
  {
    name: '軽いランニング',
    description: '体重60kgの人が時速約8kmで走った場合の消費カロリー目安',
    category: '運動',
    input_unit: 'kcal',
    output_unit: '分',
    factor: 8.3,
    calculation_type: :divide,
    reference_url: 'https://www.nibn.go.jp/activities/documents/2024Compendium_table_adult_ver1_1_5.pdf',
    icon: '🏃‍♂️'
  },
  {
    name: '電気代',
    description: '1kWhあたり31円として計算した場合の電気代目安',
    category: 'お金',
    input_unit: 'kcal',
    output_unit: '円',
    factor: 0.036,
    calculation_type: :multiply,
    reference_url: 'https://www.tepco.co.jp/ep/notice/pressrelease/2026/pdf/260428j0101.pdf',
    icon: '⚡'
  },
  {
    name: 'おにぎり',
    description: 'ご飯110gのおにぎり1個を約171.6kcalとして計算した目安',
    category: '食べ物',
    input_unit: 'kcal',
    output_unit: '個',
    factor: 171.6,
    calculation_type: :divide,
    reference_url: 'https://fooddb.mext.go.jp/details/details.pl?ITEM_NO=1_01088_7',
    icon: '🍙'
  },
  {
    name: 'ステーキ',
    description: '和牛サーロイン赤肉を100gあたり294kcalとして計算した目安',
    category: '食べ物',
    input_unit: 'kcal',
    output_unit: 'g',
    factor: 2.94,
    calculation_type: :divide,
    reference_url: 'https://fooddb.mext.go.jp/details/details.pl?ITEM_NO=11_11017_7',
    icon: '🥩'
  },
  {
    name: 'ガソリン代',
    description: 'ガソリン1Lを169.7円、発熱量33.36MJ/Lとして計算した目安',
    category: 'お金',
    input_unit: 'kcal',
    output_unit: '円',
    factor: 0.0213,
    calculation_type: :multiply,
    reference_url: 'https://nenryo-teigakuhikisage.go.jp/current_graph.pdf',
    icon: '⛽'
  },
  {
    name: '都市ガス代',
    description: '東京ガス東京地区等の都市ガスを45MJ/m³、157.19円/m³として計算した目安',
    category: 'お金',
    input_unit: 'kcal',
    output_unit: '円',
    factor: 0.0146,
    calculation_type: :multiply,
    reference_url: 'https://www.tokyo-gas.co.jp/news/press/20260428-04_01.pdf',
    icon: '🔥'
  }
]

conversions.each do |attributes|
  conversion = Conversion.find_or_initialize_by(name: attributes[:name])
  conversion.assign_attributes(attributes)
  conversion.save!
end

energy_units = [
  {
    name: "kcal",
    to_joule: 4184,
    description: "食品のエネルギー表示でよく使われる単位。日本ではカロリー表示として一般的に利用される。",
    formula_text: "1 kcal = 4184 J",
    reference_url: "https://www.e-gov.go.jp/"
  },
  {
    name: "kJ",
    to_joule: 1000,
    description: "海外の食品表示や工業分野で使われるエネルギー単位。SI単位系に基づいている。",
    formula_text: "1 kJ = 1000 J",
    reference_url: "https://www.bipm.org/"
  },
  {
    name: "MJ",
    to_joule: 1000000,
    description: "大きなエネルギー量を扱う際に使用される単位。工業・燃料・発電分野などで利用される。",
    formula_text: "1 MJ = 1000000 J",
    reference_url: "https://www.bipm.org/"
  },
  {
    name: "Wh",
    to_joule: 3600,
    description: "家電やモバイルバッテリーなどで使われる電力量の単位。",
    formula_text: "1 Wh = 3600 J",
    reference_url: "https://www.tepco.co.jp/"
  },
  {
    name: "kWh",
    to_joule: 3600000,
    description: "電気料金の計算などで一般的に使用される電力量の単位。",
    formula_text: "1 kWh = 3600000 J",
    reference_url: "https://www.tepco.co.jp/"
  },
  {
    name: "MWh",
    to_joule: 3600000000,
    description: "発電所や大規模設備など、大量の電力を扱う際に利用される単位。",
    formula_text: "1 MWh = 3600000000 J",
    reference_url: "https://www.tepco.co.jp/"
  },
  {
    name: "mAh",
    to_joule: 13.32,
    description: "スマートフォンやモバイルバッテリーの容量表示でよく使われる単位。",
    formula_text: "1 mAh ≒ 13.32 J（3.7V換算）",
    reference_url: "https://www.apple.com/jp/batteries/"
  },
  {
    name: "Ah",
    to_joule: 13320,
    description: "バッテリー容量を表す単位。車載バッテリーや蓄電池などで利用される。",
    formula_text: "1 Ah ≒ 13320 J（3.7V換算）",
    reference_url: "https://www.apple.com/jp/batteries/"
  }
]

energy_units.each do |attributes|
  energy_unit = EnergyUnit.find_or_initialize_by(name: attributes[:name])
  energy_unit.assign_attributes(attributes)
  energy_unit.save!
end
