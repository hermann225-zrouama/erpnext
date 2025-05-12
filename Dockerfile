# Utiliser l'image officielle ERPNext comme base
FROM frappe/erpnext:v15.59.0

# Définir l'utilisateur (frappe est l'utilisateur par défaut dans l'image)
USER frappe

# Copier les fichiers personnalisés dans le répertoire approprié
# Par exemple, ajouter des styles personnalisés dans l'application frappe
# COPY custom_files/styles/custom.css /home/frappe/frappe-bench/apps/frappe/frappe/public/css/
# COPY custom_files/scripts/custom.js /home/frappe/frappe-bench/apps/frappe/frappe/public/js/
# COPY custom_files/templates/custom_template.html /home/frappe/frappe-bench/apps/frappe/frappe/templates/

# (Optionnel) Installer des dépendances supplémentaires ou exécuter des commandes bench
# Par exemple, pour ajouter une application personnalisée
# RUN bench get-app my_custom_app https://github.com/your-org/my_custom_app.git
# RUN bench --site erp.example.com install-app my_custom_app

# (Optionnel) Régénérer les assets si des fichiers statiques sont modifiés
RUN bench build --app frappe

# Maintenir le point d'entrée par défaut de l'image de base
CMD ["/home/frappe/frappe-bench/env/bin/gunicorn", "-b", "0.0.0.0:8000", "-w", "4", "-t", "120", "frappe.app:application", "--preload"]