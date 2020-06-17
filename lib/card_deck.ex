defmodule CardDeck do
  @moduledoc """
  Documentation for `CardDeck`.
  """

  @typedoc """
  one of: w[2 3 4 5 6 7 8 9 T J Q K A]
  """
  @type rank() :: String.t()

  @typedoc """
  one of: [C D H S]
  clubs, diamnds, hearts, spades
  """
  @type suit() :: String.t()

  @typedoc """
  a card with a rank and suit
  {"A", "S"} Ace of Spades
  """
  @type card() :: {rank, suit}

  @typedoc """
  A deck of cards - can be any lenght
  """
  @type deck() :: list(card)

  @ranks ~w[2 3 4 5 6 7 8 9 T J Q K A]
  @suits ~w[C D H S]
  @deck for rank <- @ranks, suit <- @suits, do: {rank, suit}

  @doc """
  Returns new card deck

  ## Examples

    iex> hd CardDeck.new()
    {"2", "C"}
    iex> length CardDeck.new()
    52

  """
  @spec new() :: deck
  def new(), do: @deck

  @doc """
  Shuffles the deck
  """
  @spec shuffle(deck) :: deck
  def shuffle(deck), do: Enum.shuffle(deck)

  @doc """
  returns shuffled deck
  """
  @spec shuffled() :: deck
  def shuffled(), do: Enum.shuffle(@deck)

  @doc """
  returns numeric value of a card

  # Examples
    iex> CardDeck.value("T") < CardDeck.value("K")
    true
    iex> CardDeck.value({"T", "C"})
    10
  """
  @spec value(card | String.t()) :: integer
  def value("A"), do: 14
  def value("T"), do: 10
  def value("J"), do: 11
  def value("Q"), do: 12
  def value("K"), do: 13
  def value({rank, _suit}), do: value(rank)
  def value(number_value), do: String.to_integer(number_value)

  @doc """
  Returns rank of card
  # Examples
    iex> CardDeck.rank({"T", "C"})
    "T"
  """
  def rank({rank, _suit}), do: rank
  def suit({_rank, suit}), do: suit

  @doc """
  Returns size of deck
  # Examples
  iex> CardDeck.new() |> CardDeck.size()
  52
  """
  def size(deck), do: length(deck)

  @doc """
  Sorts a deck by rank

  ## Examples

    iex> CardDeck.sort_by_rank([{"T", "C"}, {"2", "D"}])
    [{"2", "D"}, {"T", "C"}]
  """
  @spec sort_by_rank(deck) :: deck
  def sort_by_rank(deck) do
    Enum.sort(deck, &(value(&1) <= value(&2)))
  end

  @doc """
  Sorts a deck by suit

  ## Examples

    iex> CardDeck.sort_by_suit([{"2", "D"}, {"9", "C"}])
    [{"9", "C"}, {"2", "D"}]
  """
  @spec sort_by_suit(deck) :: deck
  def sort_by_suit(deck) do
    Enum.sort(deck, &(suit(&1) <= suit(&2)))
  end

  @doc """
  Sorts a deck by rank

  ## Examples

    iex> CardDeck.new() |> CardDeck.shuffle() |> CardDeck.sort() |> hd
    {"2", "C"}

  """
  @spec sort(deck) :: deck
  def sort(deck), do: deck |> sort_by_rank() |> sort_by_suit()

  @doc """
  Deals amount of card from deck

  # Examples

    iex> CardDeck.new() |> CardDeck.deal() |> elem(0)
    [{"2", "C"}]
    iex> CardDeck.new() |> CardDeck.deal(5) |> elem(0)
    [{"2", "C"}, {"2", "D"}, {"2", "H"}, {"2", "S"}, {"3", "C"}]
    iex> CardDeck.new() |> CardDeck.deal(55)
    :error
  """
  @spec deal(deck) :: {deck, deck} | :error
  def deal(deck, cards \\ 1)

  def deal(deck, cards) when length(deck) >= cards do
    Enum.split(deck, cards)
  end

  def deal(_, _), do: :error

  @doc """
  Drops cards at selected indexes

  # Examples
    iex> CardDeck.new() |> CardDeck.drop([0,1,2,3]) |> hd
    {"3", "C"}
  """
  @spec drop(deck, [integer]) :: deck
  def drop(deck, positions_list) do
    deck
    |> Enum.with_index()
    |> Enum.filter(fn {_c, i} ->
      !Enum.member?(positions_list, i)
    end)
    |> Enum.unzip()
    |> elem(0)
  end
end
