class PayloadService

  WIN_PAYLOAD = 'windows/meterpreter/reverse_tcp'
  LINUX_PAYLOAD = 'linux/x86/reverse_tcp'
  OSX_PAYLOAD = 'osx/x86/shell_reverse_tcp'
  PHP_PAYLOAD = 'php/meterpreter_reverse_tcp'
  MULTI_PAYLOAD= 'java/meterpreter/reverse_tcp'
  GENERIC_PAYLOAD = 'generic/shell_reverse_tcp'

  def self.get_payload(module_object, payload_hint)
    unless payload_hint.nil?
      payload = load_via_hint(payload_hint)
      return payload unless payload.nil?
    end

    return get_compatible_payload(module_object)
  end

  #######
  private
  #######

  def self.load_via_hint(hint)
    hint = hint.downcase
    case hint
    when 'windows'
      return WIN_PAYLOAD
    when 'linux'
      return LINUX_PAYLOAD
    when 'osx'
      return OSX_PAYLOAD
    else
      return nil
    end
  end

  def self.get_compatible_payload(module_object)
    payloads = []
    module_object.compatible_payloads.each do |p|
      payloads << p[0]
    end

    if payloads.include?(WIN_PAYLOAD)
      return WIN_PAYLOAD
    elsif payloads.include?(LINUX_PAYLOAD)
      return LINUX_PAYLOAD
    elsif payloads.include?(OSX_PAYLOAD)
      return OSX_PAYLOAD
    elsif payloads.include?(PHP_PAYLOAD)
      return PHP_PAYLOAD
    elsif payloads.include?(MULTI_PAYLOAD)
      return MULTI_PAYLOAD
    elsif payloads.include?(GENERIC_PAYLOAD)
      return GENERIC_PAYLOAD
    else
      return nil
    end
  end
end