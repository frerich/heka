defmodule HekaWeb.PageController do
  use HekaWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
