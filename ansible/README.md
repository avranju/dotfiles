# Ansible playbooks for setting up an Ubuntu box

`base_tasks.yml` has tasks for setting up a base machine with zsh, ohmyzsh and
plugins. `playbook.yml` adds all tasks in `base_tasks.yml` and then a bunch more
to setup dev tools and things. You'll want to create an `inventory.yml` that
looks like this:

```yaml
prod:
  hosts:
    ans0:
      ansible_host: 10.125.73.35
  vars:
    ansible_user: ubuntu
    ansible_python_interpreter: /usr/bin/python3

dev:
  hosts:
    devb0:
      ansible_host: 10.125.73.43
  vars:
    ansible_user: ubuntu
    ansible_python_interpreter: /usr/bin/python3
```

`playbook.yml` will run `base_tasks.yml` on hosts in the `prod` group and all
tasks on hosts in the `dev` group. Here's how you might run it:

```bash
ansible-playbook -i inventory.yml playbook.yml
```

You can use the `dev` and `prod` tags to run just the dev and prod plays. For
example here's how you'd run only the 'dev' plays:

```bash
ansible-playbook -i inventory.yml --tags dev playbook.yml
```

Naturally, you'll want to make sure that you can SSH successfully on all the
hosts you're targetting before running the playbook.
