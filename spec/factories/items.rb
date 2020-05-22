FactoryBot.define do
  factory :item do

    name          {"Tシャツ"}
    detail        {"詳細です"}
    condition_id  {2}
    categoy_id    {5}
    price         {1000}
    fee_id        {1}
    shipping_id   {1}
    brand         {"シャネル"}
    created_at    { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }

  #   カラム名変更に伴い、コメントアウト
  #   name                   {"キャベツ"}
  #   detail                 {"採れたて"}
  #   condition              {"2"}
  #   price                  {"33333"}
  #   postage                {"2"}
  #   ship_from              {"2"}
  #   ship_date              {"2"}
  #   # accepts_neseted_attributes_for を使った場合、以下のように書かないとエラーになります。
  #   images                 { [build(:image)] }

  # end

  end

end