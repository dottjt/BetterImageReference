defmodule AuthUser do
    alias Ueberauth.Auth
    def basic_info(%Auth{} = auth) do
      {:ok,
        %{
          avatar: auth.info.image,
          email: auth.info.email,
          name: auth.info.name,
        }
      }
    end
  end