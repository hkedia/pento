defmodule Pento.Promo.Recipient do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key false

  embedded_schema do
    field :email, :string
    field :first_name, :string
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :first_name])
    |> validate_required([:email, :first_name])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/)
  end
end
