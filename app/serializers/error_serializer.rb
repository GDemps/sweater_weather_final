class ErrorSerializer
  def error(message)
    {
      data:
        {
          id: nil,
          type:"error",
          error_message: message
        }
    }
  end
end
