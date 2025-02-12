defmodule AuthPlug.Helpers do
  @doc """
  `get_baseurl_from_conn/1` derives the base URL from the conn struct
  e.g: http://localhost:4000 or https://app.dwyl.com
  """
  @spec get_baseurl_from_conn(Map) :: String.t()
  def get_baseurl_from_conn(%{host: h, port: p}) when h == "localhost" do
    "http://#{h}:#{p}"
  end

  def get_baseurl_from_conn(%{host: h}) do
    "https://#{h}"
  end


  @doc """
  `strip_struct_metadata/1` removes the Ecto Struct metadata from a struct.
  This is essential before attempting to create a JWT as `Jason.encode/2`
  chokes on any invalid data. See: github.com/dwyl/auth_plug/issues/16
  """
  def strip_struct_metadata(struct) do
    struct
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
    |> Map.delete(:statuses) # association
    |> Map.delete(:login_logs) # association
    |> Map.delete(:email_hash) # binary
  end
end
