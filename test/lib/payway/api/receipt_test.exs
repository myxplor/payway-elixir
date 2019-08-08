defmodule PayWay.API.ReceiptTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{Receipt}

  test "list receipts", %{payway_opts: payway_opts} do
    use_cassette "receipt_list_receipts" do
      %{"data" => data} = Receipt.list(payway_opts)

      assert is_list(data)
    end
  end

  test "download receipts", %{payway_opts: payway_opts} do
    use_cassette "receipt_download_receipts" do
      yyyy = "2019"
      mm = "07"
      dd = "23"
      receipts = Receipt.download(yyyy, mm, dd, payway_opts)

      assert is_binary(receipts)
    end
  end
end
