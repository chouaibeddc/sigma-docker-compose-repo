function isHumanReadableTime(value: string): string | undefined {
  const regex = /^\d+(s|m|h|d)$/i;
  const value_ = value.trim()
  if (regex.test(value_)){
    return value_
  }
}

module.exports = {isHumanReadableTime}