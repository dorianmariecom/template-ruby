module.exports = {
  project_name: 'dorianmariefr/template-ruby',
  metrics: [
    {
      name: 'todo',
      pattern: /TODO:/i,
    },
    {
      name: 'fixme',
      pattern: /FIXME:/i,
    },
    {
      name: 'rubocop',
      pattern: /rubocop:disable/,
    },
    {
      name: 'eslint',
      pattern: /eslint-disable/,
    },
  ],
}
